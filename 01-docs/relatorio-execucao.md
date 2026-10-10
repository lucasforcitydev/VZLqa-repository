# Relatório de Execução de Testes

**Projeto:** Verzel Store
**Tipo de teste:** Funcional manual e exploratório
**Ferramentas:** Google Sheets, Google Chrome e Postman
**Ambiente:** Aplicação web e API disponibilizadas para testes

## 1. Objetivo

Registrar os resultados da execução manual e exploratória dos casos de teste planejados para a aplicação Verzel Store, verificando o atendimento aos critérios de aceite e identificando possíveis falhas nas funcionalidades e regras de negócio.

## 2. Metodologia

Os casos de teste foram elaborados e organizados em uma planilha, contendo identificação, cenário, critérios de aceite, pré-condições, dados de teste, passos de execução e resultados esperados.

A execução foi realizada manualmente, utilizando o navegador para validações da interface e o Postman para requisições à API.

Os resultados obtidos foram comparados aos resultados esperados e registrados na planilha, juntamente com o status de cada caso e eventuais observações.

Também foram realizadas duas sessões exploratórias para investigar comportamentos específicos da aplicação. Os resultados foram documentados separadamente dos casos de teste planejados.

## 3. Resumo da execução

### Testes funcionais

| Indicador                 | Resultado |
| ------------------------- | --------: |
| Casos de teste planejados |        55 |
| Casos de teste executados |        55 |
| Casos aprovados           |        49 |
| Casos reprovados          |         6 |
| Taxa de aprovação         |    89,09% |
| Taxa de reprovação        |    10,91% |
| Defeitos registrados      |         3 |

### Testes exploratórios

| Indicador                    | Resultado |
| ---------------------------- | --------: |
| Sessões executadas           |         2 |
| Investigações realizadas     |        14 |
| Novos defeitos identificados |         0 |


## 4. Resultados identificados dos testes funcionais

Durante a execução, foram identificadas divergências entre os comportamentos esperados e obtidos, principalmente relacionadas às validações de regras de negócio da API.

Entre as falhas registradas, destacam-se:

* **BUG-001:** cobrança indevida de frete quando o subtotal do carrinho atinge exatamente R$ 200,00.
* **BUG-002:** ausência de validação do limite máximo de cinco unidades do mesmo produto na API.
* **BUG-003:** retorno de código de erro incorreto quando o campo obrigatório `produtoId` não é informado.

Os defeitos foram registrados separadamente, com informações sobre os cenários, resultados esperados e obtidos e evidências.

## 5. Resultados dos testes exploratórios

### EXP-001 - Cupons durante alterações no carrinho

Foram realizadas nove investigações para verificar a aplicação, remoção e reaplicação de cupons, o recálculo dos valores do carrinho e o tratamento de códigos inválidos e variações de digitação.

Os resultados observados foram consistentes com os cálculos e as regras consideradas, sem identificação de novos defeitos.

**Resultado:** Concluída - 9 investigações.

### EXP-002 - Limite de quantidade por diferentes caminhos

Foram realizadas cinco investigações para verificar o limite de cinco unidades por produto, utilizando o catálogo e os controles do carrinho.

A interface respeitou o limite nos caminhos investigados, atualizando corretamente os botões, as quantidades e os subtotais.

**Resultado:** Concluída - 5 investigações.

## 6. Conclusão

Foram executados os 55 casos de teste planejados, sendo 49 aprovados e seis reprovados, com taxa de aprovação de 89,09%.

Também foram concluídas duas sessões exploratórias, totalizando 14 investigações, sem identificação de novos defeitos.

A execução permitiu identificar três defeitos, que permanecem documentados para acompanhamento e posterior reteste.

Os resultados estão registrados na planilha de casos de teste, nos relatórios de bugs e nos documentos EXP-001 e EXP-002, garantindo a rastreabilidade das verificações realizadas.
