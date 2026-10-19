import { test, expect } from '@playwright/test';
//US-ADDR-02
// Scenario: ตรวจสอบการปิดใช้งาน Dropdown อำเภอเมื่อยังไม่ได้เลือกจังหวัด
test('TC-005-ตรวจสอบการปิดใช้งาน Dropdown อำเภอเมื่อยังไม่ได้เลือกจังหวัด', async ({ page }) => {
  await page.goto('https://storemate-final.vercel.app/');
  await page.locator('[data-test="login-btn"]').click();
  await page.locator('[data-test="email"]').click();
  await page.locator('[data-test="email"]').fill('eyejang1@gmail.com');
  await page.locator('[data-test="password"]').click();
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('E');
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('Eyejang1234');
  await page.locator('[data-test="btn-submit"]').click();
  await page.locator('[data-test="btn-user-profile"]').click();
  await page.locator('[data-test="btn-edit-profile"]').click();
  await page.getByRole('button', { name: 'จัดการที่อยู่' }).click();
  await page.locator('[data-test="btn-add-address"]').click();
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).click();
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).fill('12/2 หม');
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).press('CapsLock');
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).fill('12/2 หมู');
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).press('CapsLock');
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).fill('12/2 หมู่3');
  await expect(page.locator('select[name="district"]')).toBeDisabled();
});