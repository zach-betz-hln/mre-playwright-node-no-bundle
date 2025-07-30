import { chromium } from "playwright";

(async () => {
  const browser = await chromium.launch({
    // See https://playwright.dev/docs/browsers#chromium-new-headless-mode
    channel: "chromium",
  });
  const page = await browser.newPage();
  await page.goto("https://playwright.dev/");
  console.log(`Page title: ${await page.title()}`);
  await browser.close();
})();
