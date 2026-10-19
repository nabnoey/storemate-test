import { test, expect } from '@playwright/test';

//US-ADDR-02
// Scenario: ตรวจสอบการเพิ่มที่อยู่จัดส่งใหม่เมื่อมีที่อยู่เดิม
test('TC-003-ตรวจสอบการบันทึกและแสดงที่อยู่ใหม่ร่วมกับที่อยู่เดิม', async ({ page }) => {
  await page.goto('https://storemate-final.vercel.app/');
  await page.locator('[data-test="login-btn"]').click();
  await page.locator('[data-test="email"]').click();
  await page.locator('[data-test="email"]').fill('boom1@gmail.com');
  await page.locator('[data-test="password"]').click();
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('B');
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('Boom1234');
  await page.locator('[data-test="btn-submit"]').click();
  await page.locator('[data-test="btn-user-profile"]').click();
  await page.locator('[data-test="btn-edit-profile"]').click();
  await page.getByRole('button', { name: 'จัดการที่อยู่' }).click();
  await page.locator('[data-test="btn-add-address"]').click();
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).click();
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).fill('13/1 หม');
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).press('CapsLock');
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).fill('13/1 หมู');
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).press('CapsLock');
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' }).fill('13/1 หมู่2');
await page.locator('select[name="province"]').selectOption('9');
  await page.locator('select[name="district"]').selectOption('119');
  await page.locator('select[name="subDistrict"]').selectOption('934');
  await page.locator('[data-test="btn-save-address"]').click();
  await expect(page.getByRole('status')).toContainText('เพิ่มที่อยู่สำเร็จ');
  await expect(page.locator('#root')).toContainText('13/1 หมู่2 ต.ห้วยกรด อ.สรรคบุรี จ.ชัยนาท 17140');
  await expect(page.locator('#root')).toContainText('20/1 หมู่12 ต.นามะตูม อ.พนัสนิคม จ.ชลบุรี 20140');
  await page.locator('[data-test^="btn-delete-address-"]').first().click();
  await page.getByRole('button', { name: 'ยืนยัน' }).click();
  await page.getByText('ลบที่อยู่สำเร็จ').click();
});