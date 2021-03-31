import prisma from "../../lib/server/prisma";

const formatDate = (date) => {
  const iso = new Date(date).toISOString();

  return `${iso.split("T")[0]}`;
};

const formatDay = (date) => {
  const days = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];
  const iso = new Date(date).getDay();

  return `${days[iso]}`;
};

const formatHour = (date) => {
  const iso = new Date(date).toISOString();

  return `${iso.split("T")[1].slice(0, 5)}`;
};

const getHourAverage = (items, dbExtract) => {
  const hours = [
    "00",
    "01",
    "02",
    "03",
    "04",
    "05",
    "06",
    "07",
    "08",
    "09",
    "10",
    "11",
    "12",
    "13",
    "14",
    "15",
    "16",
    "17",
    "18",
    "19",
    "20",
    "21",
    "22",
    "23",
  ];

  const formatArray = hours.map((hour) => {
    const arr = dbExtract
      .filter((db) => {
        return formatHour(db.time).slice(0, 2) === hour;
      })
      .map((date) => [
        templates.hour.hAxis(date.time),
        ...items.map(
          (i) => parseInt(date.bids?.find((b) => b?.object === i)?.price) || 0
        ),
      ]);
    const add = arr.reduce(
      (acc, cur) =>
        cur.map((c, i) => {
          return !i ? c : (acc[i] || 0) + c;
        }),
      []
    );
    const avg =
      arr.length > 0
        ? add.map((a, i) => (!i ? `${hour}h` : a / arr.length))
        : [`${hour}h`, ...items.map(() => 0)];
    return avg;
  });

  return formatArray;
};

const getDayAverage = (items, dbExtract) => {
  const days = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];

  const formatArray = days.map((day) => {
    const arr = dbExtract
      .filter((db) => {
        return formatDay(db.time) === day;
      })
      .map((date) => [
        templates.day.hAxis(date.time),
        ...items.map(
          (i) => parseInt(date.bids?.find((b) => b?.object === i)?.price) || 0
        ),
      ]);
    const add = arr.reduce(
      (acc, cur) =>
        cur.map((c, i) => {
          return !i ? c : (acc[i] || 0) + c;
        }),
      []
    );
    const avg =
      arr.length > 0
        ? add.map((a, i) => (!i ? `${day}` : a / arr.length))
        : [`${day}`, ...items.map(() => 0)];
    return avg;
  });

  return formatArray;
};

const getDateAverage = (items, dbExtract) => {
  return dbExtract.map((db) => {
    return [
      formatDate(db.time),
      ...items.map(
        (i) => parseInt(db.bids.find((b) => b.object === i)?.price) || 0
      ),
    ];
  });
};

const templates = {
  hour: {
    hAxis: formatHour,
    take: 24,
    series: 4,
    average: getHourAverage,
  },
  day: {
    hAxis: formatDay,
    take: 7,
    series: 4,
    average: getDayAverage,
  },
  week: {
    hAxis: formatDate,
    take: 5,
    series: 1,
    average: getDateAverage,
  },
};

export default async (req, res) => {
  const { freq, items, server } = req.body;

  const dbExtract = await prisma.history.findMany({
    include: {
      bids: {
        where: {
          object: { in: items },
        },
      },
    },
    take: templates[freq].take * templates[freq].series,
    orderBy: {
      time: "desc",
    },
    where: {
      server,
      type: freq,
    },
  });

  const orderedDbExtract = dbExtract.reduce((acc, cur) => [cur, ...acc], []);

  const result = [
    ["Time", ...items],
    ...templates[freq].average(items, orderedDbExtract),
  ];

  res
    .status(200)
    .json(
      JSON.stringify(result, (_, v) =>
        typeof v === "bigint" ? v.toString() : v
      )
    );
};
