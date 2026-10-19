import { test, expect } from '@playwright/test';

//US-ADDR-03
// Scenario: ตรวจสอบการแก้ไขข้อมูลที่อยู่จัดส่งและบันทึกสำเร็จ
test('TC-006-ตรวจสอบการบันทึกข้อมูลที่อยู่จัดส่งหลังจากแก้ไขสำเร็จ', async ({ page }) => {
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
  await page.locator('[data-test^="btn-edit-address-"]').first().click();
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).click();
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).fill('10/2 หมู่7');
  await page.locator('select[name="province"]').selectOption('9');
  await page.locator('select[name="district"]').selectOption('118');
  await page.locator('select[name="subDistrict"]').selectOption('931');
  await page.locator('[data-test="btn-save-address"]').click();
  await expect(page.getByText('แก้ไขที่อยู่สำเร็จ')).toBeVisible();
});