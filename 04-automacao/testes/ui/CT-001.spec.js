import { test, expect } from '@playwright/test';

test('CT-001 - Aplicar cupom válido BEMVINDO10', async ({ page }) => {

  // DADO que o cliente possui produtos no carrinho

  await page.goto('https://verzel-store.qa-test-verzel-store.workers.dev/');

  await page
    .getByRole('article', { name: 'Camiseta Essencial' })
    .getByRole('button')
    .click();

  await page
    .getByRole('link', { name: 'Carrinho 1 itens no carrinho' })
    .click();

  // Verificar se o produto foi adicionado ao carrinho
  await expect(
    page.getByText('Camiseta Essencial')
  ).toBeVisible();

  // QUANDO aplica o cupom BEMVINDO10

  await page
    .getByRole('textbox', { name: 'Cupom de desconto' })
    .fill('BEMVINDO10');

  await page
    .getByRole('button', { name: 'Aplicar cupom' })
    .click();

  // ENTÃO o sistema deve conceder 10% de desconto sobre o subtotal

  // Para a Camiseta Essencial:
  // Subtotal: R$ 59,90
  // Desconto esperado: - R$ 5,99

  await expect(
    page.getByText('- R$ 5,99', { exact: true })
  ).toBeVisible();

});