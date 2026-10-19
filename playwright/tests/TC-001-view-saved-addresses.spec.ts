import { test, expect } from '@playwright/test';
// US-ADDR-01
// Scenario: ตรวจสอบการแสดงรายการและรายละเอียดที่อยู่จัดส่งที่บันทึกไว้
test('TC-001-ตรวจสอบการเข้าสู่หน้าจัดการที่อยู่จัดส่งผ่านเมนูโปรไฟล์สำเร็จ', async ({ page }) => {
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
  await expect(page).toHaveURL('https://storemate-final.vercel.app/address-profile');
});