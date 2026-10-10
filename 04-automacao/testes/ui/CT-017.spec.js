import { test, expect } from '@playwright/test';

test('CT-017 - Impedir mais de 5 unidades do mesmo produto', async ({ page }) => {

  // DADO que o cliente possui 5 unidades do produto P001 no carrinho

  // 1. Acessar a loja
  await page.goto('https://verzel-store.qa-test-verzel-store.workers.dev/');

  // 2. Adicionar a Camiseta Essencial ao carrinho
  await page
    .getByRole('article', { name: 'Camiseta Essencial' })
    .getByRole('button')
    .click();

  // 3. Acessar o carrinho
  await page
    .getByRole('link', { name: 'Carrinho 1 itens no carrinho' })
    .click();

  // 4. Localizar o controle de quantidade
  const quantidade = page.getByRole('status', {
    name: 'Quantidade de Camiseta'
  });

  const botaoAumentar = page.getByRole('button', {
    name: 'Aumentar quantidade de'
  });

  // 5. Confirmar a quantidade inicial
  await expect(quantidade).toHaveText('1');

  // 6. Aumentar a quantidade até 5 unidades
  for (let i = 1; i < 5; i++) {
    await botaoAumentar.click();
  }

  // 7. Confirmar que o carrinho possui 5 unidades
  await expect(quantidade).toHaveText('5');

  // QUANDO tenta adicionar uma sexta unidade

  // 8. Verificar se o botão de aumentar está desabilitado
  await expect(botaoAumentar).toBeDisabled();

  // ENTÃO o sistema deve impedir a adição da sexta unidade

  // 9. Confirmar que a quantidade permanece em 5
  await expect(quantidade).toHaveText('5');

  // 10. Validar a mensagem de limite
  await expect(
    page.getByText('Limite de 5 unidades por produto.')
  ).toBeVisible();

  // 11. Validar o subtotal correspondente a 5 unidades
  await expect(
    page.getByText('R$ 299,50', { exact: true }).first()
  ).toBeVisible();

});