import { test, expect } from '@playwright/test';

/**
 * Cenário: API-03
 * Critérios de aceite: CA06 e CA07
 *
 * CT-022: Frete para subtotal inferior a R$ 200,00
 * CT-023: Frete para subtotal igual a R$ 200,00
 * CT-024: Frete para subtotal superior a R$ 200,00
 */

const cenarios = [
  {
    id: 'CT-022',
    descricao: 'Frete fixo para subtotal inferior a R$ 200,00',
    produtoId: 'P001',
    quantidade: 1,
    subtotal: 59.90,
    frete: 19.90,
    freteGratis: false,
    faltante: 140.10,
    total: 79.80
  },
  {
    id: 'CT-023',
    descricao: 'Frete grátis para subtotal igual a R$ 200,00',
    produtoId: 'P005',
    quantidade: 2,
    subtotal: 200.00,
    frete: 0.00,
    freteGratis: true,
    faltante: 0.00,
    total: 200.00
  },
  {
    id: 'CT-024',
    descricao: 'Frete grátis para subtotal superior a R$ 200,00',
    produtoId: 'P007',
    quantidade: 1,
    subtotal: 229.90,
    frete: 0.00,
    freteGratis: true,
    faltante: 0.00,
    total: 229.90
  }
];

test.describe('API-03 - Calcular frete conforme subtotal do carrinho', () => {

  for (const cenario of cenarios) {

    test(`${cenario.id} - ${cenario.descricao}`, async ({ request }) => {

      // DADO que o carrinho possui a quantidade informada
      // do produto correspondente e não possui cupom aplicado.

      const dadosRequisicao = {
        itens: [
          {
            produtoId: cenario.produtoId,
            quantidade: cenario.quantidade
          }
        ]
      };

      // QUANDO envio uma requisição POST para /api/carrinho/calcular.

      const response = await request.post(
        'https://verzel-store.qa-test-verzel-store.workers.dev/api/carrinho/calcular',
        {
          headers: {
            'Content-Type': 'application/json'
          },
          data: dadosRequisicao
        }
      );

      // ENTÃO a API deve retornar uma resposta JSON.

      const body = await response.json();

      // Registrar informações para facilitar a análise de falhas.

      console.log(`\n========== ${cenario.id} ==========`);

      console.log('Produto:', cenario.produtoId);
      console.log('Quantidade:', cenario.quantidade);
      console.log('Status HTTP:', response.status());

      console.log('Resposta da API:');
      console.log(JSON.stringify(body, null, 2));

      // 1. Validar status HTTP 200.

      expect.soft(
        response.status(),
        `${cenario.id}: status HTTP incorreto`
      ).toBe(200);

      // 2. Validar subtotal.

      expect.soft(
        body.subtotal,
        `${cenario.id}: subtotal incorreto`
      ).toBeCloseTo(cenario.subtotal, 2);

      // 3. Validar frete.

      expect.soft(
        body.frete,
        `${cenario.id}: valor do frete incorreto`
      ).toBeCloseTo(cenario.frete, 2);

      // 4. Validar indicador de frete grátis.

      expect.soft(
        body.freteGratis,
        `${cenario.id}: indicador freteGratis incorreto`
      ).toBe(cenario.freteGratis);

      // 5. Validar valor faltante para frete grátis.
      // Nome da propriedade confirmado na resposta real da API.

      expect.soft(
        body.valorFaltanteFreteGratis,
        `${cenario.id}: valor faltante para frete grátis incorreto`
      ).toBeCloseTo(cenario.faltante, 2);

      // 6. Validar total do pedido.

      expect.soft(
        body.total,
        `${cenario.id}: total do pedido incorreto`
      ).toBeCloseTo(cenario.total, 2);

      // 7. Validar ausência de cupom aplicado.

      expect.soft(
        body.cupom,
        `${cenario.id}: não deveria existir cupom aplicado`
      ).toBeNull();

      // 8. Validar ausência de desconto.

      expect.soft(
        body.desconto,
        `${cenario.id}: não deveria existir desconto`
      ).toBeCloseTo(0, 2);

    });

  }

});