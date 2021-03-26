const { PrismaClient } = require("@prisma/client");
const prisma = new PrismaClient();

const extractText = (domElement) => {
  return domElement.contents().first().text().trim();
};

const extractItem = async (itemRow, auctionId, c, id) => {
  const image = c("td.firstCol_history img", itemRow)[0]?.attribs?.src;
  if (!image) return;

  const name = extractText(c("td.auction_history_name_col", itemRow));
  const owner = extractText(c("td.auction_history_winner", itemRow));
  const price = extractText(c("td.auction_history_current", itemRow));
  const [item] = image?.match(/([a-z0-9\-]*)_30x30.png/m)[0].split("_30");

  const create = {
    id: [id, name.replace(/\s/gm, "-").toLowerCase()].join("-"),
    object: item.replace("-eic", "").replace("-mmo", "").replace("-vru", ""),
    owner,
    price: parseInt(price.replace(/\./gm, "")),
  };
  return create;
};

const scrapSolds = async (time, server, filter, c) => {
  const id = time.attribs.id;
  const date = new Date(time.firstChild.data);

  console.log("👀 Checking for entry in the database");
  const entryExists = await prisma.history.findFirst({
    where: { auction_id: id, server },
  });

  if (entryExists) {
    console.log("⚠️ Entry already in our database, skipping...");
    return;
  }
  console.log(`⬆️ Adding ${id} auction history in the database`);
  const auctionId = await prisma.history
    .create({
      data: {
        auction_id: id,
        time: date.toISOString(),
        type: filter,
        server,
      },
    })
    .catch(console.error);

  const itemRows = c(`.auction_list_history #auction_${id} tr`);

  const parsedItems = await Promise.all(
    itemRows.map(async (_, itemRow) => extractItem(itemRow, auctionId, c, id))
  );

  console.log(
    `⬆️ Adding new bought items in the database [${parsedItems
      .map((pi) => pi.object)
      .join(", ")}]`
  );

  const multiInsert = await prisma.history
    .update({
      data: {
        bids: {
          createMany: { data: parsedItems, skipDuplicates: true },
        },
      },
      where: {
        id: auctionId.id,
      },
    })
    .catch(console.error);

  return multiInsert;
};

module.exports = { scrapSolds };
