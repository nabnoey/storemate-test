import { test, expect } from '@playwright/test';
//US-ADDR-04
// Scenario: ตรวจสอบการเปลี่ยนที่อยู่เริ่มต้นเป็นที่อยู่อื่นที่บันทึกไว้
test('TC-011-ตรวจสอบการเปลี่ยนที่อยู่เริ่มต้นและสถานะปุ่มตั้งค่าเริ่มต้น', async ({ page }) => {
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
  await expect(page.locator('[data-test="btn-set-default"]').first()).toBeDisabled();
  await expect(page.locator('[data-test="btn-set-default"]').nth(1)).toBeEnabled();
  await page.locator('[data-test="btn-set-default"]').nth(1).click();
  await expect(page.locator('[data-test="btn-set-default"]:disabled')).toHaveCount(1);
})