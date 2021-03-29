const puppeteer = require("puppeteer");
const cheerio = require("cheerio");
const { PrismaClient } = require("@prisma/client");
// const config = require("dotenv").config().parsed;

const { URL } = require("url");

const { scrapSolds } = require("./src/scrapSolds.js");

const prisma = new PrismaClient();

const useFirstServer = async (page, serverId) =>
  new Promise(async (resolve) => {
    const url = new URL(page.url());
    await page.goto(`${url}/indexInternal.es?action=internalAuction`, {
      waitUntil: "networkidle0",
    });
    await page.click(".css-flk0bs", { clickCount: 4 }).catch(() => {});
    await page.click("#header_button_server", {
      clickCount: 4,
    });
    setTimeout(async () => {
      await page.click(`tr#serverSelection_ini_${serverId}`, {
        clickCount: 1,
      });
      resolve(true);
    }, 5000);
  });

const scrapServer = async (page, servers, i) => {
  const server = servers[i].tag;

  console.log(`🚢 Navigating to auction page`);
  await page.goto(
    `https://${server}.darkorbit.com/indexInternal.es?action=internalAuction`,
    { waitUntil: "networkidle0" }
  );
  console.log(`⚓ Just arrived in auction page`);

  const c = cheerio.load(await page.content());

  const filters = ["hour", "day", "week"];

  await Promise.all(
    filters.map(async (filter) => {
      console.log(`🕷️ Scraping ${filter}s auctions`);
      const times = c(`#auction_history_selection_${filter} div.filter_item`);
      console.log("⌚ Waiting for page");
      return Promise.all(
        times.map(async (_, time) => scrapSolds(time, server, filter, c))
      );
    })
  );

  if (servers[i + 1]) {
    await page.click("#header_button_server", {
      clickCount: 4,
    });
    setTimeout(async () => {
      await page
        .click(`#serverSelection_${servers[i + 1].tab}_tab`, {
          clickCount: 1,
        })
        .catch((err) => console.error(err));

      setTimeout(async () => {
        console.log(`🚢 Navigating to the server ${servers[i + 1].tag}`);
        await page.click(`#serverSelection_ini_${servers[i + 1].do_id}`, {
          clickCount: 1,
        });
        console.log(`⚓ Just arrived in server ${servers[i + 1].tag}`);
        scrapServer(page, servers, i + 1);
      }, 1000);
    }, 5000);
  } else {
    console.log("✌️ Mission accomplished!");
  }

  return;
};

const scrap = async () => {
  const servers = await prisma.servers.findMany();
  console.log("📃 Getting server list");

  const browser = await puppeteer.launch({
    headless: true,
    defaultViewport: null,
    timeout: 0,
    args: ["--no-sandbox"],
  });
  const page = await browser.newPage();
  console.log("🚢 Navigating to https://darkorbit.com");
  const navigation = await page
    .goto("https://www.darkorbit.com", {
      waitUntil: "load",
      timeout: 0,
    })
    .catch(() => {
      console.log(
        `❌ Unable to load https://www.darkorbit.com\n🔃 Retrying...`
      );
      main();
    });

  if (!navigation) return;

  console.log("➕ Filling username and password");
  await page.type("#bgcdw_login_form_username", process.env.USERNAME);
  await page.type("#bgcdw_login_form_password", process.env.PASSWORD);

  console.log("👨‍💻 Log the user in");
  await Promise.all([
    await page
      .click(".css-flk0bs", { delay: "500", clickCount: 1 })
      .catch(() => {}),
    await page.click(".bgcdw_button.bgcdw_login_form_login"),
    page.waitForNavigation({ waitUntil: "networkidle0", timeout: 0 }),
  ]);
  console.log("🏴‍☠ We're in captain!");

  console.log(`🚢 Navigating to the server ${servers[0].tag}`);
  await useFirstServer(page, servers[0].do_id);
  console.log(`⚓ Just arrived in server ${servers[0].tag}`);

  let i = 0;
  await scrapServer(page, servers, i);
};

(function main() {
  console.log("🏁 Here we go");
  scrap();
  setInterval(() => {
    console.log("🏁 Here we go");
    scrap();
  }, 3 * 60 * 60 * 1000);
})();
