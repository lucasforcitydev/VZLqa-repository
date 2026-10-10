# Relatório de Bugs - Verzel Store

**Projeto:** Verzel Store
**Tipo de teste:** Funcional manual e exploratório
**Quantidade de bugs identificados:** 3
**Status:** Pendentes de correção e reteste

## 1. Objetivo

Consolidar os defeitos identificados durante a execução manual e exploratória dos casos de teste da aplicação Verzel Store, apresentando as divergências entre os resultados esperados e obtidos.

## 2. Resumo dos bugs

| ID      | Descrição                                   | Resultado esperado                                                             | Resultado obtido                                                      |
| ------- | ------------------------------------------- | ------------------------------------------------------------------------------ | --------------------------------------------------------------------- |
| BUG-001 | Falha na aplicação do frete grátis          | Frete grátis para subtotal a partir de R$ 200,00.                              | Interface e API cobram R$ 19,90 de frete quando o subtotal é exatamente R$ 200,00. |
| BUG-002 | API permite quantidade superior ao limite   | Rejeitar quantidade superior a cinco unidades com HTTP 422.                    | API aceita seis unidades e retorna HTTP 200.                          |
| BUG-003 | Código de erro incorreto para item inválido | Retornar HTTP 422 e código `ITEM_INVALIDO` quando `produtoId` estiver ausente. | API retorna HTTP 422 com código `PRODUTO_NAO_ENCONTRADO`.             |

## 3. Validação dos defeitos

Os três defeitos foram identificados durante os testes manuais e posteriormente reproduzidos por meio de testes automatizados com Playwright.

| Bug     | Caso de teste | Resultado da automação |
| ------- | ------------- | ---------------------- |
| BUG-001 | CT-023        | Defeito reproduzido    |
| BUG-002 | CT-034        | Defeito reproduzido    |
| BUG-003 | CT-045        | Defeito reproduzido    |

## 4. Documentação e evidências

Os detalhes de cada defeito, incluindo os passos para reprodução, resultados esperados e obtidos, estão disponíveis nos arquivos individuais:

* `01-docs/bugs/BUG-001.md`
* `01-docs/bugs/BUG-002.md`
* `01-docs/bugs/BUG-003.md`

As evidências estão organizadas na pasta `03-evidencias/`, separadas por identificador do bug.

## 5. Conclusão

Foram identificados três defeitos relacionados às regras de negócio e às validações da API.

Os problemas foram documentados e reproduzidos por testes automatizados, confirmando as divergências observadas durante a execução manual.

Os defeitos permanecem pendentes de correção e posterior reteste.
