# EXP-002 - Limite de quantidade por diferentes caminhos

## Registro da sessão

| Campo | Registro |
|---|---|
| Projeto | Verzel Store |
| Tipo | Teste exploratório manual - UI |
| Status | Concluída |
| Responsável | José Lucas |
| Data | 10/10/2026 |
| Hora de início | Não informada |
| Hora de término | Não informada |
| Duração informada | 25 minutos |
| Ambiente | https://verzel-store.qa-test-verzel-store.workers.dev/ |
| Versão da aplicação | 2.3.0 |
| Navegador | Google Chrome |
| Sistema operacional | Windows 11 |
| Referência | CA10 |

## Objetivo

Investigar o limite de cinco unidades por produto por diferentes caminhos da interface, incluindo catálogo e carrinho, e verificar se quantidades, subtotais, mensagens e estados dos controles acompanham as alterações.

## Preparação

- O carrinho continha produtos ao iniciar a sessão.
- Foi utilizada a ação **Esvaziar carrinho**.
- O carrinho ficou vazio após a ação, conforme confirmado pelo executor.
- Produto de referência: **P001 - Camiseta Essencial**, R$ 59,90 por unidade.
- Segundo produto: **Boné Aba Curva**, R$ 49,90 por unidade.

## Regras investigadas

- O limite é de **cinco unidades de cada produto**, não cinco unidades para o carrinho inteiro.
- O catálogo e o carrinho devem impedir a sexta unidade do mesmo produto.
- Os botões devem refletir a quantidade atual após aumento, diminuição e remoção.
- Quantidades e subtotais devem acompanhar as mudanças.

## Diário da exploração

| Seq. | Ação e dados | Resultado observado | Próxima investigação / motivo | Evidência |
|---|---|---|---|---|
| 0 | Inspecionar o carrinho e esvaziá-lo. | Havia produtos; a ação **Esvaziar carrinho** funcionou e o carrinho ficou vazio. | Estabelecer condição inicial. | Relato do executor. |
| 1 | Adicionar P001 pelo catálogo até cinco unidades e verificar a possibilidade de uma sexta. | Cinco unidades adicionadas. O botão **Adicionar ao carrinho** ficou desabilitado, com a mensagem **“Limite de 5 unidades atingido.”**. Carrinho exibiu cinco unidades. | Verificar se o limite também é respeitado pelo controle do carrinho. | Relato do executor. |
| 2 | Com cinco unidades de P001, inspecionar o botão `+` no carrinho. | Botão `+` desabilitado; sexta unidade não permitida; mensagem **“Limite de 5 unidades por produto”**; quantidade permaneceu em cinco; subtotal **R$ 299,50**. | Verificar se a redução de quantidade reabilita o catálogo. | Relato do executor. |
| 3 | Reduzir P001 de cinco para quatro no carrinho; voltar ao catálogo; adicionar mais uma unidade. | Redução bem-sucedida; subtotal **R$ 239,60**; botão do catálogo reabilitado; quinta unidade adicionada; carrinho voltou a cinco; botão novamente desabilitado. | Verificar liberação dos controles após remoção completa. | Relato do executor. |
| 4 | Remover completamente P001, voltar ao catálogo e adicioná-lo novamente. | Produto removido; carrinho vazio; botão do catálogo reabilitado; nova adição permitida; carrinho exibiu uma unidade e subtotal **R$ 59,90**. | Investigar se o limite é individual por produto. | Relato do executor. |
| 5 | Completar cinco unidades de P001 e adicionar cinco unidades de Boné Aba Curva. | Sistema permitiu **5 camisetas + 5 bonés**. Controles de adição ficaram desabilitados no catálogo e no carrinho ao atingir o limite. Ambos os produtos exibiram **“Limite de 5 unidades por produto.”**. Subtotais: camisetas **R$ 299,50**, bonés **R$ 249,50**. Resumo: subtotal **R$ 549,00**, desconto **R$ 0,00**, frete **Grátis**, total **R$ 549,00**. | Encerrar sessão: limite individual confirmado na UI. | Relato e transcrição da tela fornecidos pelo executor. |


## Verificações de cálculo

| Cenário | Cálculo | Resultado observado | Situação |
|---|---|---|---|
| 5 camisetas | 5 × R$ 59,90 = R$ 299,50 | R$ 299,50 | Conforme |
| 4 camisetas | 4 × R$ 59,90 = R$ 239,60 | R$ 239,60 | Conforme |
| 1 camiseta | 1 × R$ 59,90 = R$ 59,90 | R$ 59,90 | Conforme |
| 5 bonés | 5 × R$ 49,90 = R$ 249,50 | R$ 249,50 | Conforme |
| 5 camisetas + 5 bonés | R$ 299,50 + R$ 249,50 = R$ 549,00 | R$ 549,00 | Conforme |


## Encerramento

**Resumo:** Foram realizadas cinco investigações, além da preparação, cobrindo limite pelo catálogo, limite pelo carrinho, redução e reabilitação dos controles, remoção completa e nova adição, e aplicação do limite a dois produtos diferentes. Os resultados relatados foram consistentes com a regra de cinco unidades **por produto**, e os subtotais conferiram.

**Resultado geral:** concluída, sem novos defeitos identificados na UI nos caminhos explorados.

**Bugs:** 0.