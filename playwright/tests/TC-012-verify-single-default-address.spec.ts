import { test, expect } from '@playwright/test';
//US-ADDR-04
// Scenario: ตรวจสอบว่าระบบแสดงที่อยู่เริ่มต้นเพียงรายการเดียว
test('TC-012-ตรวจสอบจำนวนป้ายสถานะที่อยู่เริ่มต้นว่ามีเพียงหนึ่งรายการ', async ({ page }) => {
  await page.goto('https://storemate-final.vercel.app/');
  await page.locator('[data-test="login-btn"]').click();
  await page.locator('[data-test="email"]').click();
  await page.locator('[data-test="email"]').fill('eyejang1@gmail.com');
  await page.locator('[data-test="password"]').click();
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('E');
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('Eyejang1234');
  await page.locator('[data-test="password"]').press('Enter');
  await page.locator('[data-test="btn-user-profile"]').click();
  await page.locator('[data-test="btn-edit-profile"]').click();
  await page.getByRole('button', { name: 'จัดการที่อยู่' }).click();
  await expect(page.getByText('ค่าเริ่มต้น', { exact: true })).toHaveCount(1);
})