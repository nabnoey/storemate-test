import { test, expect } from '@playwright/test';
//US-ADDR-02
// Scenario: ตรวจสอบการป้องกันการบันทึกเมื่อกรอกข้อมูลที่อยู่ไม่ครบถ้วน
test('TC-004-ตรวจสอบการแจ้งเตือนเมื่อบันทึกที่อยู่โดยกรอกข้อมูลไม่ครบ', async ({ page }) => {
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
  await page.locator('select[name="province"]').selectOption('15');
  await page.locator('select[name="district"]').selectOption('180');
  await page.locator('select[name="subDistrict"]').selectOption('1452');
  await page.locator('[data-test="btn-save-address"]').click();
  await expect(page.getByText('กรุณากรอกข้อมูลให้ครบถ้วน')).toBeVisible();
  await page.locator('[data-test="btn-cancel-address"]').click();
  // await expect(page.locator('#root')).toContainText('10/2 หมู่2 ต.บางเสร่ อ.สัตหีบ จ.ชลบุรี 20250');
  // await expect(page.locator('#root')).toContainText('10/1 หมู่1 ต.พระบุ อ.พระยืน จ.ขอนแก่น 40320');
});