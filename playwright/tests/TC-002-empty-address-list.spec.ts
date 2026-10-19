import { test, expect } from '@playwright/test';

//US-ADDR-02
// Scenario: ตรวจสอบการแสดงผลเมื่อผู้ใช้งานไม่มีที่อยู่จัดส่ง
test('TC-002-ตรวจสอบการแสดงข้อความแจ้งเตือนเมื่อไม่มีข้อมูลที่อยู่จัดส่ง', async ({ page }) => {
  await page.goto('https://storemate-final.vercel.app/');
  await page.locator('[data-test="login-btn"]').click();
  await page.locator('[data-test="email"]').click();
  await page.locator('[data-test="email"]').fill('jaturong1@gmail.com');
  await page.locator('[data-test="password"]').click();
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('J');
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('Jaturong1234');
  await page.locator('[data-test="btn-submit"]').click();
  await page.locator('[data-test="btn-user-profile"]').click();
  await page.locator('[data-test="btn-edit-profile"]').click();
  await page.getByRole('button', { name: 'จัดการที่อยู่' }).click();
  await expect(page.getByText('ไม่มีข้อมูลที่อยู่ของคุณ')).toBeVisible();
});