import { test, expect } from '@playwright/test';
//US-ADDR-04
// Scenario: ตรวจสอบการป้องกันการลบที่อยู่สุดท้ายของผู้ใช้งาน

test('TC-009-ตรวจสอบการแจ้งเตือนเมื่อพยายามลบที่อยู่เริ่มต้นรายการสุดท้าย', async ({ page }) => {
  // const status = page.getByRole('status');
  await page.goto('https://storemate-final.vercel.app/');
  await page.locator('[data-test="login-btn"]').click();
  await page.locator('[data-test="email"]').click();
  await page.locator('[data-test="email"]').fill('ployy@gmail.com');
  await page.locator('[data-test="password"]').click();
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('P');
  await page.locator('[data-test="password"]').press('CapsLock');
  await page.locator('[data-test="password"]').fill('Ploy1234');
  await page.locator('[data-test="password"]').press('Enter');
  await page.locator('[data-test="btn-user-profile"]').click();
  await page.locator('[data-test="btn-edit-profile"]').click();
  await page.getByRole('button', { name: 'จัดการที่อยู่' }).click();
  await page.locator('[data-test="btn-delete-address-459"]').click();
await expect(
  page.getByRole('status').filter({
    hasText: 'ไม่สามารถลบได้ เนื่องจากต้องมีที่อยู่เริ่มต้นอย่างน้อย 1 รายการ'
  })
).toBeVisible();
  // await expect(page.getByRole('status', { name: 'ไม่สามารถลบได้ เนื่องจากต้องมีที่อยู่เริ่มต้นอย่างน้อย 1 รายการ' })).toBeVisible();
  // await expect(page.getByRole('status')).toContainText('ไม่สามารถลบได้ เนื่องจากต้องมีที่อยู่เริ่มต้นอย่างน้อย 1 รายการ');
  // await expect(page.getByText('ไม่สามารถลบได้ เนื่องจากต้องมีที่อยู่เริ่มต้นอย่างน้อย 1 รายการ')).toBeVisible();
})