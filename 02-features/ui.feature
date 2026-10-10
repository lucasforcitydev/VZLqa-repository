# language: pt
# Card: VZS-142
# Versão: 2.3.0

@VZS-142
Funcionalidade: Cupom de desconto e frete grátis
    Como cliente da Verzel Store
    Quero aplicar cupons de desconto e ganhar frete grátis em compras maiores
    Para pagar menos nas minhas compras


@CA01
@CEN-001
Cenário: Aplicar cupom válido BEMVINDO10
    Dado que o cliente possui produtos no carrinho
    Quando aplica o cupom "BEMVINDO10"
    Então o sistema deve conceder 10% de desconto sobre o subtotal

@CA02
@CEN-002
Esquema do Cenário: Aceitar cupom independentemente de letras maiúsculas e minúsculas
    Dado que o cliente possui produtos no carrinho
    Quando aplica o cupom "<codigo>"
    Então o sistema deve reconhecer o cupom como válido
    E conceder 10% de desconto sobre o subtotal dos produtos

    Exemplos:
        | codigo     |
        | bemvindo10 |
        | BeMvInDo10 |

# {ESP} representa um espaço em branco real.
# Na execução, substituir cada {ESP} por um espaço antes de aplicar o cupom.
@CA02 
@CEN-003
Esquema do Cenário: Ignorar espaços no início e no final do código do cupom
    Dado que o cliente possui produtos no carrinho
    Quando aplica o cupom "<codigo>"
    Então o sistema deve reconhecer o cupom como válido
    E conceder 10% de desconto sobre o subtotal dos produtos

    Exemplos:
        | codigo             |
        |{ESP}BEMVINDO10     |
        |BEMVINDO10{ESP}     |
        |{ESP}BEMVINDO10{ESP}|

@CA03
@CEN-004
Cenário: Cupom inexistente exibe mensagem de erro e não aplica desconto
    Dado que o cliente possui produtos no carrinho
    E não possui cupom aplicado
    Quando aplica o cupom "INVALIDO123"
    Então o sistema deve exibir a mensagem "Cupom inválido."
    E não deve aplicar nenhum desconto sobre o subtotal

@CA04
@CEN-005
Cenário: Rejeitar aplicação de cupom expirado
    Dado que o cliente possui produtos no carrinho
    E não possui cupom aplicado
    E o cupom "VERAO2026" está expirado na data do teste
    Quando aplica o cupom "VERAO2026"
    Então o sistema deve exibir a mensagem "Cupom expirado."
    E não deve aplicar desconto sobre o subtotal

@CA05 
@CEN-006
Cenário: Impedir aplicação simultânea de dois cupons
    Dado que o cliente possui produtos no carrinho
    Quando aplica o cupom "BEMVINDO10"
    Então o sistema deve conceder 10% de desconto sobre o subtotal
    E o campo onde digita o cupom deve ser desabilitado para impedir a aplicação de outro cupom

@CA05 @CA04
@CEN-007
Cenário: Remover cupom válido e tentar aplicar cupom expirado
    Dado que o cliente possui produtos no carrinho
    E já possui o cupom "BEMVINDO10" aplicado
    E o cupom "VERAO2026" está expirado na data do teste
    Quando o cliente remove o cupom aplicado
    Então o sistema deve remover o desconto do carrinho
    E permitir a aplicação de outro cupom
    Quando o cliente aplica o cupom "VERAO2026"
    Então o sistema deve exibir a mensagem "Cupom expirado."
    E não deve aplicar nenhum desconto sobre o subtotal


@CA06
@CEN-008
Esquema do Cenário: Conceder frete grátis para compras a partir de R$ 200,00
    Dado que o cliente possui <quantidade> unidade(s) do produto "<produtoId>" no carrinho
    E não possui cupom aplicado
    Quando o sistema calcula o valor do frete
    Então o subtotal deve ser de R$ <subtotal>
    E o frete deve ser de R$ 0,00
    E o total do pedido deve ser de R$ <total>

    Exemplos:
        | produtoId | quantidade | subtotal | total  |
        | P005      | 2          | 200,00   | 200,00 |
        | P007      | 1          | 229,90   | 229,90 |

@CA07
@CEN-009
Esquema do Cenário: Cobrar frete fixo para compras abaixo de R$ 200,00
    Dado que o cliente possui <quantidade1> unidade(s) do produto "<produto1>" no carrinho
    E possui <quantidade2> unidade(s) do produto "<produto2>" no carrinho
    E não possui cupom aplicado
    Quando o sistema calcula o valor do frete
    Então o subtotal deve ser de R$ <subtotal>
    E o frete deve ser de R$ 19,90
    E o carrinho deve informar que faltam R$ <valor_faltante> para o frete grátis
    E o total do pedido deve ser de R$ <total>

    Exemplos:
        | produto1 | quantidade1 | produto2 | quantidade2 | subtotal | valor_faltante | total  |
        | P005     | 1           | P008     | 1           | 150,00   | 50,00          | 169,90 |
        | P002     | 1           | P006     | 2           | 199,70   | 0,30           | 219,60 |


@CA08 
@CEN-010
Cenário: Manter frete grátis quando o desconto reduz o subtotal para menos de R$ 200,00
    Dado que o cliente possui produtos no carrinho
    E o subtotal antes do desconto é de R$ 200,00
    Quando aplica o cupom "BEMVINDO10"
    Então o sistema deve aplicar R$ 20,00 de desconto sobre o subtotal
    E deve manter o frete grátis de R$ 0,00
    E o total do pedido deve ser de R$ 180,00


@CA09 
@CEN-011
Cenário: Aplicar desconto do cupom somente sobre o subtotal dos produtos
    Dado que o cliente possui produtos no carrinho
    E o subtotal do carrinho é de R$ 100,00
    E o frete é de R$ 19,90
    Quando aplica o cupom "BEMVINDO10"
    Então o sistema deve aplicar R$ 10,00 de desconto sobre o subtotal
    E deve manter o valor do frete em R$ 19,90
    E o total do pedido deve ser de R$ 109,90


@CA10 
@CEN-012
Cenário: Impedir adição de mais de 5 unidades do mesmo produto pela interface
    Dado que o cliente possui 5 unidades do produto "P001" no carrinho
    Quando tenta adicionar uma sexta unidade do mesmo produto
    Então o sistema deve impedir a adição da sexta unidade
    E a quantidade do produto "P001" deve permanecer em 5 unidades


@CA11 
@CEN-013
Cenário: Validar cálculo e apresentação dos valores monetários com duas casas decimais
    Dado que o cliente possui 1 unidade do produto "P001" no carrinho
    E o subtotal do carrinho é de R$ 59,90
    Quando aplica o cupom "BEMVINDO10"
    E o sistema calcula o desconto, o frete e o total do pedido
    Então o subtotal deve ser de R$ 59,90
    E o desconto deve ser de R$ 5,99
    E o frete deve ser de R$ 19,90
    E o total do pedido deve ser de R$ 73,81
    E todos os valores monetários devem respeitar a precisão de duas casas decimais

@CEN-014
Cenário: Finalizar compra com dados válidos do cliente
    Dado que o cliente possui 1 unidade do produto "P005" no carrinho
    Quando informa o nome "Maria Silva"
    E informa o e-mail "maria@exemplo.com"
    E informa o CEP "01310-100"
    E confirma o pedido
    Então o sistema deve apresentar uma confirmação de compra
    E deve exibir um número de pedido no padrão "VZ-" seguido de seis dígitos