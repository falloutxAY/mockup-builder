const { chromium } = require('playwright');
(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: 1440, height: 900 } });
  await page.goto('http://localhost:8765/mockups/rules-edit-flow1.html');
  await page.click('#addConceptBtn');
  await page.waitForTimeout(300);
  await page.evaluate(() => { selectEntity('Truck License'); });
  await page.waitForTimeout(300);
  await page.screenshot({ path: 'C:/Users/ansyeo/OneDrive - Microsoft/Documents/mockup-builder/output/mockups/screenshots/rules-edit-flow1-browser.png', fullPage: false });

  // Also take full-page without browser
  const page2 = await browser.newPage({ viewport: { width: 1440, height: 900 } });
  await page2.goto('http://localhost:8765/mockups/rules-edit-flow1.html');
  await page2.screenshot({ path: 'C:/Users/ansyeo/OneDrive - Microsoft/Documents/mockup-builder/output/mockups/screenshots/rules-edit-flow1-full.png', fullPage: true });

  await browser.close();
  console.log('Done');
})();
