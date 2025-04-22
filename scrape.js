const fs = require('fs');
const puppeteer = require('puppeteer-core');
(async () => {
  const url = process.env.SCRAPE_URL;
  if (!url) throw new Error('SCRAPE_URL not set');
  const browser = await puppeteer.launch({
    args: ['--no-sandbox','--disable-setuid-sandbox'],
    executablePath: '/usr/bin/chromium-browser'
  });
  const page = await browser.newPage();
  await page.goto(url, { waitUntil: 'networkidle2' });
  const data = {
    title: await page.title(),
    heading: await page.$eval('h1', el => el.innerText).catch(() => '')
  };
  fs.writeFileSync('scraped_data.json', JSON.stringify(data));
  await browser.close();
})();
