// Renders site/tools/og.html into site/public/assets/og-{en,ru}.png.
// Usage (from the repo root): npm i playwright && npx playwright install chromium && node site/tools/render_og.mjs
import { chromium } from 'playwright';
import { fileURLToPath } from 'node:url';
import path from 'node:path';

const here = path.dirname(fileURLToPath(import.meta.url));
const browser = await chromium.launch();
const page = await browser.newPage({ viewport: { width: 1200, height: 630 } });
for (const lang of ['en', 'ru']) {
  await page.goto(`file://${here}/og.html?lang=${lang}`);
  await page.waitForSelector('body[data-ready]');
  await page.screenshot({ path: path.join(here, '..', 'public', 'assets', `og-${lang}.png`) });
}
await browser.close();
