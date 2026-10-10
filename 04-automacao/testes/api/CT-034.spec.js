import { test, expect } from '@playwright/test';

/**
 * CT-034 - Rejeitar quantidade superior a cinco unidades
 *
 * Cenário: API-07B
 * Critério de aceite: CA10
 * Tipo: API
 * Prioridade: Alta
 */

test('CT-034 - Rejeitar quantidade superior a 5 unidades', async ({ request }) => {

  // DADO que o carrinho possui 6 unidades do produto P001

  const dadosRequisicao = {
    itens: [
      {
        produtoId: 'P001',
        quantidade: 6
      }
    ]
  };

  // QUANDO envio uma requisição POST para /api/carrinho/calcular

  const response = await request.post(
    'https://verzel-store.qa-test-verzel-store.workers.dev/api/carrinho/calcular',
    {
      headers: {
        'Content-Type': 'application/json'
      },
      data: dadosRequisicao
    }
  );

  // Registrar o status HTTP e a resposta da API

  const body = await response.json();

  console.log('\n========== CT-034 ==========');
  console.log('Status HTTP:', response.status());
  console.log('Resposta da API:');
  console.log(JSON.stringify(body, null, 2));

  // ENTÃO a API deve retornar o status HTTP 422

  expect.soft(
    response.status(),
    'A API deveria rejeitar quantidade superior a 5 unidades com HTTP 422'
  ).toBe(422);

  // E o código de erro deve ser QUANTIDADE_MAXIMA_EXCEDIDA

  expect.soft(
    body.erro?.codigo,
    'A API deveria retornar o código QUANTIDADE_MAXIMA_EXCEDIDA'
  ).toBe('QUANTIDADE_MAXIMA_EXCEDIDA');

});