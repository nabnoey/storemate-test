import { test, expect } from '@playwright/test';

let newAddressId: string;
let countBefore: number;

//US-ADDR-04
// Scenario: ตรวจสอบการลบที่อยู่จัดส่งที่ไม่ใช่ค่าเริ่มต้น
test.beforeEach(async ({ page }) => {
  // Login
  await page.goto('https://storemate-final.vercel.app/');
  await page.locator('[data-test="login-btn"]').click();
  await page.locator('[data-test="email"]').click();
  await page.locator('[data-test="email"]').fill('makwid@gmail.com');
  await page.locator('[data-test="password"]').click();
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('M');
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('Makwid1234');
  await page.locator('[data-test="password"]').press('Enter');

  // เข้าหน้าจัดการที่อยู่
  await page.getByTestId('btn-user-profile').click();
  await page.getByTestId('btn-edit-profile').click();
  await page.getByRole('button', { name: 'จัดการที่อยู่' }).click();
  //   await page.locator('[data-test="btn-user-profile"]').click();
  // await page.locator('[data-test="btn-edit-profile"]').click();
  // await page.getByRole('button', { name: 'จัดการที่อยู่' }).click();

  const addresses = page.getByTestId('address-detail');
  const buttons = page.locator('[data-test^="btn-delete-address-"]');

  countBefore = await addresses.count();
  const oldIds = await buttons.evaluateAll(els =>
    els.map(el => el.getAttribute('data-test'))
  );

  // Precondition: สร้างที่อยู่
  await page.getByTestId('btn-add-address').click();
  await page.getByRole('textbox', { name: 'บ้านเลขที่ / ถนน / ซอย' })
    .fill(`${Math.floor(Math.random() * 9999) + 1} หมู่ 5`);

  await page.locator('select[name="province"]').selectOption('69');
  await page.locator('select[name="district"]').selectOption('912');
  await page.locator('select[name="subDistrict"]').selectOption('8129');
  await page.getByTestId('btn-save-address').click();

  await expect(addresses).toHaveCount(countBefore + 1);

  const newIds = await buttons.evaluateAll(els =>
    els.map(el => el.getAttribute('data-test'))
  );

  newAddressId = newIds.find(id => id && !oldIds.includes(id)) ?? '';
  if (!newAddressId) throw new Error('ไม่พบที่อยู่ที่สร้างใหม่');
});

test('TC-008-ตรวจสอบการลบที่อยู่จัดส่งที่ไม่ใช่ค่าเริ่มต้นสำเร็จและคงสถานะที่อยู่เริ่มต้นไว้', async ({ page }) => {
  await page.locator(`[data-test="${newAddressId}"]`).click();
  await page.getByRole('button', { name: 'ยืนยัน' }).click();

  await expect(
    page.getByRole('status').filter({ hasText: 'ลบที่อยู่สำเร็จ' })
  ).toBeVisible();

  await expect(page.getByTestId('address-detail')).toHaveCount(countBefore);

  await expect(
    page.getByText('ค่าเริ่มต้น', { exact: true })
  ).toHaveCount(1);
});