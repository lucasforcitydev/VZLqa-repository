# Verzel Store - Desafio Técnico QA Júnior

Este repositório reúne as entregas realizadas durante o desafio técnico de Quality Assurance (QA) da aplicação Verzel Store.

O trabalho contempla planejamento de testes, execução manual e exploratória, documentação de defeitos, cenários em Gherkin e automação de testes funcionais utilizando Playwright e JavaScript.

## 1. Organização do repositório

```text
VZLqa-repository/
│
├── README.md
├── .gitignore
│
├── 01-docs/
│   ├── bugs/
│   │   ├── BUG-001.md
│   │   ├── BUG-002.md
│   │   ├── BUG-003.md
│   │   └── relatorio-bugs.md
│   │
│   ├── casos-de-teste/
│   │   ├── casos-de-teste.md
│   │   └── casos-de-teste-VZL-qa-jr
│   │
│   ├── teste-exploratorios/
│   │   ├── EXP-001-cupons-alteracoes-carrinho.md
│   │   └── EXP-002-limite-quantidade.md
│   │
│   └── relatorio-execucao.md
│
├── 02-features/
│   ├── api.feature
│   └── ui.feature
│
├── 03-evidencias/
│   ├── BUG-001/
│   ├── BUG-002/
│   └── BUG-003/
│
└── 04-automacao/
    ├── testes/
    │   ├── api/
    │   │   ├── CT-023.spec.js
    │   │   ├── CT-025.spec.js
    │   │   ├── CT-034.spec.js
    │   │   └── CT-045.spec.js
    │   │
    │   └── ui/
    │       ├── CT-001.spec.js
    │       └── CT-017.spec.js
    │
    ├── package.json
    ├── package-lock.json
    └── playwright.config.js
```

## 2. Onde encontrar cada entrega

| Entrega | Acesso |
|---|---|
| Casos de teste | [📊 Acessar planilha](https://docs.google.com/spreadsheets/d/1D8cIj7rnweAFTRR4CLZ8eaYqaDbbqTMlnkfWNttHvUY/edit?usp=sharing) |
| Casos de teste — XLSX no repositório | [📊 Visualizar XLSX](<01-docs/casos-de-teste/casos-de-teste-VZL-qa-jr.xlsx>) |
| Relatório de execução manual e exploratória | [📄 Visualizar relatório](01-docs/relatorio-execucao.md) |
| Relatório de defeitos | [🐞 Visualizar relatório](01-docs/bugs/relatorio-bugs.md) |
| BUG-001 - Frete grátis | [🔍 Visualizar bug](01-docs/bugs/BUG-001.md) |
| BUG-002 - Limite de quantidade | [🔍 Visualizar bug](01-docs/bugs/BUG-002.md) |
| BUG-003 - Validação de campo obrigatório | [🔍 Visualizar bug](01-docs/bugs/BUG-003.md) |
| Evidências dos defeitos | [📸 Visualizar evidências](03-evidencias/) |
| Cenários BDD - API | [📝 Visualizar cenários](02-features/api.feature) |
| Cenários BDD - Interface | [📝 Visualizar cenários](02-features/ui.feature) |
| Testes automatizados de API | [⚙️ Visualizar testes](04-automacao/testes/api/) |
| Testes automatizados de interface | [⚙️ Visualizar testes](04-automacao/testes/ui/) |
| Testes exploratórios | [🔎 Visualizar sessões](01-docs/teste-exploratorios/) |

Os casos de teste foram planejados e registrados em uma planilha, com identificação, critérios de aceite, pré-condições, dados de teste, procedimentos, resultados esperados e obtidos, status e observações.

## 3. Execução manual e exploratória

Foram planejados e executados manualmente 55 casos de teste, contemplando verificações funcionais da interface e da API.

| Indicador            | Resultado |
| -------------------- | --------: |
| Casos planejados     |        55 |
| Casos executados     |        55 |
| Casos aprovados      |        49 |
| Casos reprovados     |         6 |
| Defeitos registrados |         3 |
| Taxa de aprovação    |    89,09% |

Os resultados detalhados estão disponíveis na planilha de casos de teste e no relatório de execução manual.

## 4. Tecnologias e ferramentas

* **JavaScript:** linguagem utilizada na automação.
* **Playwright:** framework de testes automatizados.
* **Node.js e npm:** ambiente de execução e gerenciamento de dependências.
* **Postman:** execução manual de requisições à API.
* **Google Chrome:** execução manual dos testes de interface.
* **Google Sheets:** planejamento e registro dos casos de teste.
* **Git e GitHub:** versionamento e organização das entregas.

## 5. Como executar os testes automatizados

### Pré-requisitos

Para executar os testes, é necessário ter instalado:

* Node.js 20 ou superior;
* npm;
* Git.

A aplicação Verzel Store também precisa estar disponível no ambiente de testes.

### Passo 1 - Clonar o repositório

Abra o terminal e execute:

```bash
git clone https://github.com/lucasforcitydev/VZLqa-repository.git
```

Acesse a pasta do projeto:

```bash
cd VZLqa-repository
```

As entregas estão na branch `main`, utilizada ao clonar o repositório.

### Passo 2 - Acessar a pasta de automação

```bash
cd 04-automacao
```

### Passo 3 - Instalar as dependências

```bash
npm install
```

### Passo 4 - Instalar o navegador do Playwright

```bash
npx playwright install chromium
```

### Passo 5 - Executar os testes


**Executar todos os testes automatizados:**

```bash
npx playwright test
```

**Executar somente os testes de API:**

```bash
npx playwright test testes/api
```

**Executar somente os testes de interface:**

```bash
npx playwright test testes/ui
```

**Executar um arquivo específico:**

```bash
npx playwright test testes/api/CT-025.spec.js
```

**Executar os testes de interface com o navegador visível:**

```bash
npx playwright test testes/ui --headed
```

### Passo 6 - Visualizar o relatório

Após a execução, utilize:

```bash
npx playwright show-report
```

O Playwright abrirá o relatório HTML com os resultados dos testes executados.

## 6. Resultados dos testes automatizados

Foram desenvolvidos e executados **16 casos de teste automatizados** utilizando Playwright e JavaScript, contemplando validações da API e da interface da aplicação Verzel Store.

### 6.1. Resumo da execução

| Indicador        | API | Interface (UI) |  Total |
| ---------------- | --: | -------------: | -----: |
| Casos executados |  14 |              2 | **16** |
| Casos aprovados  |  11 |              2 | **13** |
| Casos reprovados |   3 |              0 |  **3** |

**Taxa de aprovação:** 81,25%.

### 6.2. Testes de API

Foram executados 14 casos de teste de API, sendo 11 aprovados e três reprovados.

Os três casos reprovados reproduziram defeitos identificados anteriormente durante a execução manual.

| Caso   | Defeito identificado                                            | Resultado |
| ------ | --------------------------------------------------------------- | --------- |
| CT-023 | BUG-001 - Frete grátis não aplicado no subtotal de R$ 200,00    | ❌ Falhou  |
| CT-034 | BUG-002 - API aceita quantidade superior a cinco unidades       | ❌ Falhou  |
| CT-045 | BUG-003 - Código de erro incorreto para ausência de `produtoId` | ❌ Falhou  |

### 6.3. Testes de interface (UI)

Foram executados dois casos de teste automatizados de interface, ambos aprovados.

| Caso   | Cenário validado                                                          | Resultado |
| ------ | ------------------------------------------------------------------------- | --------- |
| CT-001 | Aplicação de cupom e validação dos valores apresentados no carrinho       | ✅ Passou  |
| CT-017 | Validação do limite máximo de cinco unidades do mesmo produto no carrinho | ✅ Passou  |

Os testes estão disponíveis em `04-automacao/testes/ui/`.

### 6.4. Considerações sobre os resultados

Os testes automatizados foram desenvolvidos com base nos critérios de aceite e nos resultados esperados definidos durante o planejamento.

Os três testes reprovados identificaram divergências entre o comportamento da API e as regras de negócio estabelecidas.

As asserções foram mantidas conforme os resultados esperados, permitindo que os testes sejam reutilizados para verificar as correções em futuras execuções de regressão.


## 7. Documentação dos defeitos

Foram identificados três defeitos durante a execução manual:

**BUG-001 - Frete grátis**

A interface e a API não aplicam o frete grátis quando o subtotal do carrinho é exatamente R$ 200,00, cobrando indevidamente R$ 19,90.

**BUG-002 - Limite de quantidade**

A API permite processar seis unidades do mesmo produto, apesar da regra de limite máximo de cinco unidades.

**BUG-003 - Validação de campo obrigatório**

Ao receber um item sem `produtoId`, a API retorna o código `PRODUTO_NAO_ENCONTRADO`, quando o esperado é `ITEM_INVALIDO`.

Cada defeito possui documentação individual e evidências disponíveis nas pastas correspondentes.
