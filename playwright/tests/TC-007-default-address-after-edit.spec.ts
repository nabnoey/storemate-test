import { test, expect } from '@playwright/test';
//US-ADDR-03
// Scenario: ตรวจสอบการกำหนดที่อยู่ที่แก้ไขเป็นค่าเริ่มต้น
test('TC-007-ตรวจสอบการแสดงปุ่มตั้งเป็นที่อยู่เริ่มต้นหลังแก้ไขที่อยู่จัดส่ง', async ({ page }) => {
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
  await page.getByTestId(/^btn-edit-address-\d+$/).nth(1).click();
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).click();
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' })
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' })
  .fill(`${Math.floor(Math.random() * 999) + 1}/${Math.floor(Math.random() * 99) + 1} หมู่ ${Math.floor(Math.random() * 15) + 1}`);
  // await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).fill('10/2 หมู่10');
  await page.locator('select[name="province"]').selectOption('69'); 
  await page.locator('select[name="district"]').selectOption('911');
  await page.locator('select[name="subDistrict"]').selectOption('8119');
  await page.locator('[data-test="btn-save-address"]').click();
  await expect(page.getByText('แก้ไขที่อยู่สำเร็จ')).toBeVisible()
  await expect(page.locator('[data-test="btn-set-default"]').first()).toBeVisible();
});