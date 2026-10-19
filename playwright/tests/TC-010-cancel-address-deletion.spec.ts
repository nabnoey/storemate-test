import { test, expect } from '@playwright/test';

//US-ADDR-04
// Scenario: ตรวจสอบการยกเลิกการลบที่อยู่จัดส่ง
test('TC-010-ตรวจสอบการคงอยู่ของข้อมูลที่อยู่จัดส่งเมื่อยกเลิกการลบ', async ({ page }) => {
  await page.goto('https://storemate-final.vercel.app/');
  await page.locator('[data-test="login-btn"]').click();
  await page.locator('[data-test="email"]').click();
  await page.locator('[data-test="email"]').fill('num1@gmail.com');
  await page.locator('[data-test="password"]').click();
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('N');
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('Numm1234');
  await page.locator('[data-test="password"]').press('Enter');
  await page.locator('[data-test="btn-user-profile"]').click();
  await page.locator('[data-test="btn-edit-profile"]').click();
  await page.getByRole('button', { name: 'จัดการที่อยู่' }).click();
  await page.locator('[data-test="btn-delete-address-504"]').click();
  await page.getByRole('button', { name: 'ยกเลิก' }).click();
  await expect(page.locator('#root')).toContainText('10/1 หมู่1 ต.บางหลวง อ.บางเลน จ.นครปฐม 73190');
}) 