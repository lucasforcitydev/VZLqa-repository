import { test, expect } from '@playwright/test';

/**
 * Cenário: API-13
 * Tipo: API
 * Prioridade: Alta
 *
 * Casos de teste: CT-043 a CT-051
 */

const cenarios = [
  {
    id: 'CT-043',
    descricao: 'Rejeitar ausência de itens',
    dados: {},
    codigoEsperado: 'ITENS_OBRIGATORIOS'
  },
  {
    id: 'CT-044',
    descricao: 'Rejeitar lista de itens vazia',
    dados: {
      itens: []
    },
    codigoEsperado: 'ITENS_OBRIGATORIOS'
  },
  {
    id: 'CT-045',
    descricao: 'Rejeitar item sem produtoId',
    dados: {
      itens: [
        {
          quantidade: 1
        }
      ]
    },
    codigoEsperado: 'ITEM_INVALIDO'
  },
  {
    id: 'CT-046',
    descricao: 'Rejeitar quantidade zero',
    dados: {
      itens: [
        {
          produtoId: 'P001',
          quantidade: 0
        }
      ]
    },
    codigoEsperado: 'QUANTIDADE_INVALIDA'
  },
  {
    id: 'CT-047',
    descricao: 'Rejeitar quantidade negativa',
    dados: {
      itens: [
        {
          produtoId: 'P001',
          quantidade: -1
        }
      ]
    },
    codigoEsperado: 'QUANTIDADE_INVALIDA'
  },
  {
    id: 'CT-048',
    descricao: 'Rejeitar quantidade decimal',
    dados: {
      itens: [
        {
          produtoId: 'P001',
          quantidade: 1.5
        }
      ]
    },
    codigoEsperado: 'QUANTIDADE_INVALIDA'
  },
  {
    id: 'CT-049',
    descricao: 'Rejeitar quantidade não numérica',
    dados: {
      itens: [
        {
          produtoId: 'P001',
          quantidade: 'texto'
        }
      ]
    },
    codigoEsperado: 'QUANTIDADE_INVALIDA'
  },
  {
    id: 'CT-050',
    descricao: 'Rejeitar produto duplicado',
    dados: {
      itens: [
        {
          produtoId: 'P001',
          quantidade: 1
        },
        {
          produtoId: 'P001',
          quantidade: 2
        }
      ]
    },
    codigoEsperado: 'ITEM_DUPLICADO'
  },
  {
    id: 'CT-051',
    descricao: 'Rejeitar produto inexistente',
    dados: {
      itens: [
        {
          produtoId: 'P999',
          quantidade: 1
        }
      ]
    },
    codigoEsperado: 'PRODUTO_NAO_ENCONTRADO'
  }
];

test.describe('API-13 - Rejeitar itens inválidos no cálculo do carrinho', () => {

  for (const cenario of cenarios) {

    test(`${cenario.id} - ${cenario.descricao}`, async ({ request }) => {

      // DADO que o corpo da requisição contém o JSON informado

      const dadosRequisicao = cenario.dados;

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

      // Converter a resposta da API em objeto JavaScript

      const body = await response.json();

      // Registrar informações para análise

      console.log(`\n========== ${cenario.id} ==========`);

      console.log('Dados enviados:');
      console.log(JSON.stringify(dadosRequisicao, null, 2));

      console.log('Status HTTP:', response.status());

      console.log('Resposta da API:');
      console.log(JSON.stringify(body, null, 2));

      // ENTÃO a API deve retornar HTTP 422

      expect.soft(
        response.status(),
        `${cenario.id}: a API deveria retornar HTTP 422`
      ).toBe(422);

      // E o código de erro deve corresponder ao esperado

      expect.soft(
        body.erro?.codigo,
        `${cenario.id}: código de erro incorreto`
      ).toBe(cenario.codigoEsperado);

    });

  }

});