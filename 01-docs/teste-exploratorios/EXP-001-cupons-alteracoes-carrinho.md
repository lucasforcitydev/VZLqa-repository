# EXP-001 - Cupons durante alterações no carrinho

## Registro da sessão

| Campo | Preenchimento |
|---|---|
| Projeto | Verzel Store |
| Tipo | Exploratório manual — UI |
| Status da sessão | Executada |
| Responsável | José Lucas |
| Data | 10/10/2026 |
| Hora de início / fim | 09:10 / 09:35 |
| Duração real | 00:25 |
| Ambiente | https://verzel-store.qa-test-verzel-store.workers.dev/ |
| Versão da aplicação | 2.3.0 |
| Navegador | Google Chrome |
| Sistema operacional | Windows 11 |
| Referências | CA01, CA02, CA03, CA04, CA05 e CA09 |

## Objetivo

Investigar se o desconto permanece coerente ao alterar produtos e trocar cupons, verificando subtotal, desconto, frete e total, além do tratamento de códigos inválidos e variações de digitação.

## Preparação

- **Condição inicial:** carrinho vazio; produto P001 disponível; cupom `BEMVINDO10` válido.
- **Verificação realizada:** o carrinho estava vazio. Um produto foi adicionado e removido em seguida, retornando ao estado vazio antes da exploração.
- **Produto P001:** Camiseta Essencial - R$ 59,90 por unidade.
- **Segundo produto:** Boné Aba Curva - R$ 49,90 por unidade.
- **Regras utilizadas:** `BEMVINDO10` concede 10% sobre o subtotal dos produtos, sem incidir sobre o frete; frete de R$ 19,90 para subtotais inferiores a R$ 200,00; apenas um cupom por vez.

## Pontos de partida para explorar

- Aplicar `BEMVINDO10` com uma unidade de P001.
- Alterar quantidade e adicionar outro produto com o cupom ativo.
- Remover produto e observar o recálculo.
- Remover cupom, testar `INVALIDO123` e reaplicar o cupom válido.
- Investigar letras minúsculas e espaços nas extremidades do código.

## Diário da exploração

| Sequência | Ação e dados utilizados | Resultado observado | Interpretação / próxima investigação | Evidência |
|---|---|---|---|---|
| 1 | Adicionar 1 Camiseta Essencial e aplicar `BEMVINDO10`. | Subtotal R$ 59,90; desconto -R$ 5,99; frete R$ 19,90; total R$ 73,81. Faltavam R$ 140,10 para frete grátis. | Cálculo consistente. Investigar aumento da quantidade. | Relato textual da execução. |
| 2 | Aumentar de 1 para 2 camisetas, mantendo o cupom. | Subtotal R$ 119,80; desconto -R$ 11,98; frete R$ 19,90; total R$ 127,72. Faltavam R$ 80,20 para frete grátis. | Desconto recalculado; cupom mantido. Investigar segundo produto. | Relato textual da execução. |
| 3 | Adicionar 1 Boné Aba Curva (R$ 49,90), mantendo 2 camisetas. | Subtotal R$ 169,70; desconto -R$ 16,97; frete R$ 19,90; total R$ 172,63. Faltavam R$ 30,30 para frete grátis. | Desconto aplicado sobre a soma dos produtos. Investigar remoção. | Relato textual da execução. |
| 4 | Remover o Boné Aba Curva, mantendo 2 camisetas e o cupom. | Subtotal R$ 119,80; desconto -R$ 11,98; frete R$ 19,90; total R$ 127,72. | Valores retornaram aos da sequência 2. Investigar retirada do cupom. | Relato textual da execução. |
| 5 | Remover `BEMVINDO10`. | Subtotal R$ 119,80; desconto R$ 0,00; frete R$ 19,90; total R$ 139,70. | Desconto removido sem alteração dos itens. Investigar cupom inválido. | Relato textual da execução. |
| 6 | Tentar aplicar `INVALIDO123`. | Mensagem `Cupom inválido.`; subtotal R$ 119,80; desconto R$ 0,00; frete R$ 19,90; total R$ 139,70. | Código rejeitado sem desconto indevido. Investigar reaplicação válida. | Relato textual da execução. |
| 7 | Substituir o código inválido por `BEMVINDO10` e aplicar. | Cupom aplicado; subtotal R$ 119,80; desconto -R$ 11,98; frete R$ 19,90; total R$ 127,72. | Tentativa inválida anterior não bloqueou o cupom válido. Investigar minúsculas. | Relato textual da execução. |
| 8 | Remover cupom e aplicar `bemvindo10` em letras minúsculas. | Aceito e exibido como `BEMVINDO10`; subtotal R$ 119,80; desconto -R$ 11,98; frete R$ 19,90; total R$ 127,72. Nenhuma mensagem de erro relatada. | Aceita minúsculas nesse código. Investigar espaços nas extremidades. | Relato textual da execução. |
| 9 | Aplicar ` BEMVINDO10 ` com espaços antes e depois. | Cupom aceito e desconto de 10% aplicado normalmente. Valores numéricos não foram informados nessa etapa. | Tolera espaços nas extremidades nesse cenário. | Relato textual da execução. |

### Conferência dos cálculos

| Situação | Cálculo | Total |
|---|---|---|
| 1 camiseta com cupom | R$ 59,90 - R$ 5,99 + R$ 19,90 | **R$ 73,81** |
| 2 camisetas com cupom | R$ 119,80 - R$ 11,98 + R$ 19,90 | **R$ 127,72** |
| 2 camisetas + 1 boné com cupom | R$ 169,70 - R$ 16,97 + R$ 19,90 | **R$ 172,63** |
| 2 camisetas sem cupom | R$ 119,80 + R$ 19,90 | **R$ 139,70** |



## Encerramento

- **Resumo do que foi investigado:** aplicação, remoção e reaplicação de cupom; recálculo de desconto após alterações no carrinho; rejeição de cupom inválido; aceitação de minúsculas e espaços nas extremidades.
- **Resultado da sessão:** executada. Os comportamentos relatados foram consistentes com os cálculos e regras considerados. A sequência 9 foi confirmada pelo responsável, sem detalhamento numérico adicional.
- **Bugs encontrados ou reproduzidos:** nenhum novo bug relatado nesta sessão.
- **Dúvidas e pontos não investigados:** confirmar documentalmente o tratamento esperado de maiúsculas/minúsculas e espaços; não foi investigado nesta sessão o uso do cupom com subtotal igual ou superior a R$ 200,00.
- **Próximos passos:** anexar capturas de tela, se disponíveis, e considerar uma sessão específica para a interação entre cupons e o limite do frete grátis.

### Indicadores

| Indicador | Resultado |
|---|---|
| Investigações registradas | 9 |
| Investigações com comportamento satisfatório informado | 9 |
| Novos bugs relatados | 0 |
| Duração | 25 minutos |
| Status final | **Executada** |
