import { test, expect } from '@playwright/test';

/**
 * CT-025 - Aplicar cupom válido e calcular valores monetários
 *
 * Cenário: API-04
 * Critérios de aceite: CA01, CA09 e CA11
 * Tipo: API
 * Prioridade: Alta
 */

test('CT-025 - Aplicar cupom BEMVINDO10 e validar valores monetários', async ({ request }) => {

  // DADO que o carrinho possui 1 unidade do produto P001
  // E o cupom informado é BEMVINDO10

  const dadosRequisicao = {
    itens: [
      {
        produtoId: 'P001',
        quantidade: 1
      }
    ],
    cupom: 'BEMVINDO10'
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

  // Validar o status antes de interpretar o corpo da resposta

  expect(response.status()).toBe(200);

  // Converter a resposta JSON em objeto JavaScript

  const body = await response.json();

  // Exibir a resposta no terminal para facilitar a análise

  console.log('\n========== CT-025 ==========');
  console.log('Status HTTP:', response.status());
  console.log('Resposta da API:');
  console.log(JSON.stringify(body, null, 2));

  // ENTÃO o subtotal deve ser de R$ 59,90

  expect.soft(
    body.subtotal,
    'Subtotal incorreto'
  ).toBeCloseTo(59.90, 2);

  // E o desconto deve ser de R$ 5,99

  expect.soft(
    body.desconto,
    'Desconto incorreto'
  ).toBeCloseTo(5.99, 2);

  // E o frete deve ser de R$ 19,90

  expect.soft(
    body.frete,
    'Frete incorreto'
  ).toBeCloseTo(19.90, 2);

  // E o total deve ser de R$ 73,81

  expect.soft(
    body.total,
    'Total incorreto'
  ).toBeCloseTo(73.81, 2);

  // E o campo cupom.aplicado deve ser true

  expect.soft(
    body.cupom?.aplicado,
    'Cupom BEMVINDO10 não foi aplicado corretamente'
  ).toBe(true);

  // E os valores monetários devem ter precisão de até duas casas decimais

  const camposMonetarios = [
    'subtotal',
    'desconto',
    'frete',
    'total'
  ];

  for (const campo of camposMonetarios) {

    const valor = body[campo];

    // Confirmar que o campo é numérico

    expect.soft(
      typeof valor,
      `O campo ${campo} deve ser numérico`
    ).toBe('number');

    // Evitar executar a verificação matemática em valores inválidos

    if (typeof valor !== 'number' || !Number.isFinite(valor)) {
      continue;
    }

    // Verificar precisão de até duas casas decimais
    // Multiplicar por 100 deve produzir um valor inteiro,

    expect.soft(
      Math.abs(valor * 100 - Math.round(valor * 100)),
      `O campo ${campo} possui mais de duas casas decimais`
    ).toBeLessThan(0.000001);

  }

});