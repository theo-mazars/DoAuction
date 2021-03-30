import React from "react";
import axios from "axios";
import Head from "next/head";
import styles from "../styles/Home.module.css";
import { Chart } from "react-google-charts";
import { ReactSearchAutocomplete } from "react-search-autocomplete";

export default function Home({ items, servers }) {
  const [config, setConfig] = React.useState({
    freq: "hour",
    items: [],
    server: "default",
  });
  const [prices, setPrices] = React.useState({});

  React.useEffect(() => {
    if (!config.items.length) return;
    (async () => {
      const apiRes = await axios.post("/api/fetchPrices", config);

      if (!apiRes.data) return;

      setPrices(apiRes.data);
    })();
  }, [config]);

  React.useEffect(() => {
    document.body.addEventListener(
      "DOMSubtreeModified",
      () =>
        document.querySelectorAll("rect").forEach((rect) => {
          rect.setAttribute("rx", 30);
        }),
      false
    );
  }, []);

  const handleConfigChange = ({ target: { name, value } }) =>
    setConfig({
      ...config,
      [name]: value,
      items: name === "freq" ? [] : config.items,
    });

  const handleOnSearch = (string, results) => {
    console.log(string, results);
  };

  const handleOnSelect = (item) => {
    setConfig({ ...config, items: [...config.items, item.tag] });
  };

  const handleOnFocus = () => {
    console.log("Focused");
  };

  const handleItemRemove = (tag) => {
    const newItemsList = config.items.reduce(
      (acc, cur) => (cur === tag ? acc : [...acc, cur]),
      []
    );
    setConfig({ ...config, items: newItemsList });
  };

  return prices && config ? (
    <div className={styles.container}>
      <Head>
        <title>DoAuction - Home</title>
        <link rel="icon" href="/favicon.ico" />
        <meta charset="UTF-8" />
      </Head>

      <main className={styles.main}>
        <h1 className={styles.title}>
          Welcome to <a href="https://do-auction.com">DoAuction</a>
        </h1>

        <div style={{ borderRadius: 30 }}>
          {config.items.length &&
          config.server !== "default" &&
          prices.length ? (
            <object
              width={800}
              height={400}
              style={{ border: "none", borderRadius: 30 }}
            >
              <Chart
                width={800}
                height={400}
                chartType="LineChart"
                loader={<div>Loading Chart</div>}
                data={prices}
                options={{
                  vAxis: {
                    title: "Average price (Credits)",
                    minValue: 0,
                    textStyle: {
                      color: "#fff",
                    },
                    titleTextStyle: {
                      color: "#fefefe",
                      italic: true,
                    },
                    viewWindow: {
                      min: 0,
                    },
                  },
                  vAxes: [
                    { gridLines: "#efefef" },
                    { gridLines: "#efefef" },
                    { gridLines: "#efefef" },
                  ],
                  legend: {
                    textStyle: {
                      color: "#fff",
                    },
                  },
                  hAxis: {
                    title: "Date",
                    textStyle: {
                      color: "#fff",
                    },
                    titleTextStyle: {
                      color: "#fefefe",
                      italic: true,
                    },
                    slantedTextAngle: 30,
                  },
                  backgroundColor: "#2c2e43",
                  pointSize: 7,
                }}
                style={{ borderRadius: 30, color: "#fff" }}
              />
            </object>
          ) : (
            <></>
          )}
        </div>

        <div className={styles.config}>
          <div>
            <select
              defaultValue="default"
              name="server"
              onChange={handleConfigChange}
            >
              <option value="default" disabled>
                Choose your server
              </option>
              {servers.length &&
                servers.map((server) => (
                  <option value={server.tag} key={server.tag}>
                    {server.name}
                  </option>
                ))}
            </select>
          </div>

          <div className={styles.frequency}>
            <div className={styles.option}>
              <input
                id="hour"
                type="radio"
                name="freq"
                value="hour"
                checked={config.freq === "hour"}
                onChange={handleConfigChange}
              />
              <label htmlFor="hour">Hourly</label>
            </div>
            <div className={styles.option}>
              <input
                id="day"
                type="radio"
                name="freq"
                value="day"
                checked={config.freq === "day"}
                onChange={handleConfigChange}
              />
              <label htmlFor="day">Daily</label>
            </div>
            <div className={styles.option}>
              <input
                id="week"
                type="radio"
                name="freq"
                value="week"
                checked={config.freq === "week"}
                onChange={handleConfigChange}
              />
              <label htmlFor="week">Weekly</label>
            </div>
          </div>

          <div style={{ width: "100%" }}>
            <div style={{ width: "50%", zIndex: 999 }}>
              <ReactSearchAutocomplete
                items={items.filter(
                  (i) =>
                    i.frequency === config.freq &&
                    !config.items?.find((ci) => ci === i.tag)
                )}
                onSearch={handleOnSearch}
                onSelect={handleOnSelect}
                onFocus={handleOnFocus}
                autoFocus
              />
            </div>
          </div>

          {config.items && items && (
            <div className={styles.filters}>
              {config.items?.map((item) => {
                const it = items.find((i) => i.tag === item);
                return it ? (
                  <span key={it.tag} onClick={() => handleItemRemove(it.tag)}>
                    × {it.tag}
                  </span>
                ) : (
                  <span key={item}></span>
                );
              })}
            </div>
          )}
        </div>
      </main>

      <footer className={styles.footer}>DoAuction &copy;2021</footer>
    </div>
  ) : (
    <></>
  );
}

export async function getServerSideProps() {
  const items = await axios.get(`${process.env.API_URL}/api/fetchItems`);
  const servers = await axios.get(`${process.env.API_URL}/api/fetchServers`);

  if (!items.data || !servers.data)
    return {
      notFound: true,
    };
  return { props: { items: items.data, servers: servers.data } };
}
