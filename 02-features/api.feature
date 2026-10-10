# language: pt
# Card: VZS-142
# Versão: 2.3.0
# Testes funcionais da API da Verzel Store
#
#- Loja: https://verzel-store.qa-test-verzel-store.workers.dev/
#- API: https://verzel-store.qa-test-verzel-store.workers.dev/api


@VZS-142 @API
Funcionalidade: Validar produtos, carrinho e pedidos pela API
    Como consumidor da API da Verzel Store
    Quero consultar produtos e validar cálculos e pedidos
    Para garantir o cumprimento das regras de negócio

    Contexto:
        Dado que a API da Verzel Store está disponível
        E que as requisições com corpo utilizam o formato JSON
        E que o cabeçalho "Content-Type" é "application/json" nas requisições com corpo


    @API-01
    Cenário: Consultar lista de produtos
        Quando envio uma requisição GET para "/api/produtos"
        Então a API deve retornar o status HTTP 200
        E a resposta deve conter uma lista de produtos
        E cada produto deve possuir "id", "nome", "descricao", "categoria" e "preco"


    @API-02
    Cenário: Consultar produto inexistente
        Dado que o produto "P999" não existe no catálogo
        Quando envio uma requisição GET para "/api/produtos/P999"
        Então a API deve retornar o status HTTP 404
        E o código de erro deve ser "PRODUTO_NAO_ENCONTRADO"


    @API-03 @CA06 @CA07
    Esquema do Cenário: Calcular frete conforme subtotal do carrinho
        Dado que o carrinho possui <quantidade> unidade(s) do produto "<produtoId>"
        E não possui cupom aplicado
        Quando envio uma requisição POST para "/api/carrinho/calcular"
        Então a API deve retornar o status HTTP 200
        E o subtotal deve ser de R$ <subtotal>
        E o frete deve ser de R$ <frete>
        E o campo "freteGratis" deve ser <freteGratis>
        E o valor faltante para frete grátis deve ser de R$ <faltante>
        E o total deve ser de R$ <total>

        Exemplos:
            | quantidade | produtoId | subtotal | frete | freteGratis | faltante | total  |
            | 1          | P001      | 59,90    | 19,90 | false       | 140,10   | 79,80  |
            | 2          | P005      | 200,00   | 0,00  | true        | 0,00     | 200,00 |
            | 1          | P007      | 229,90   | 0,00  | true        | 0,00     | 229,90 |


    @API-04 @CA01 @CA09 @CA11
    Cenário: Aplicar cupom válido e calcular valores monetários
        Dado que o carrinho possui 1 unidade do produto "P001"
        E o cupom informado é "BEMVINDO10"
        Quando envio uma requisição POST para "/api/carrinho/calcular"
        Então a API deve retornar o status HTTP 200
        E o subtotal deve ser de R$ 59,90
        E o desconto deve ser de R$ 5,99
        E o frete deve ser de R$ 19,90
        E o total deve ser de R$ 73,81
        E o campo "cupom.aplicado" deve ser true
        E os valores monetários devem ter precisão de até duas casas decimais


# {ESP} representa um espaço em branco real.
# Na execução, substituir cada {ESP} por um espaço antes de aplicar o cupom.
    @API-05 @CA02
    Esquema do Cenário: Aceitar cupom com variações de letras e espaços
        Dado que o carrinho possui 1 unidade do produto "P001"
        E o cupom informado é "<cupom>"
        Quando envio uma requisição POST para "/api/carrinho/calcular"
        Então a API deve retornar o status HTTP 200
        E o campo "cupom.aplicado" deve ser true
        E o desconto deve ser de R$ 5,99

        Exemplos:
            | cupom                  |
            | bemvindo10             |
            | BeMvInDo10             |
            | {ESP}BEMVINDO10         |
            | BEMVINDO10{ESP}         |
            | {ESP}BEMVINDO10{ESP}    |


    @API-06 @CA03 @CA04
    Esquema do Cenário: Rejeitar cupom inválido ou expirado no cálculo
        Dado que o carrinho possui 1 unidade do produto "P001"
        E o cupom "VERAO2026" está expirado na data do teste
        E o cupom informado é "<cupom>"
        Quando envio uma requisição POST para "/api/carrinho/calcular"
        Então a API deve retornar o status HTTP 200
        E o campo "cupom.aplicado" deve ser false
        E a mensagem do cupom deve ser "<mensagem>"
        E o desconto deve ser de R$ 0,00
        E o total deve ser de R$ 79,80

        Exemplos:
            | cupom      | mensagem        |
            | INVALIDO123 | Cupom inválido. |
            | VERAO2026  | Cupom expirado. |


    @API-07 @CA10
    Cenário: Aceitar quantidade máxima de cinco unidades
        Dado que o carrinho possui 5 unidades do produto "P001"
        Quando envio uma requisição POST para "/api/carrinho/calcular"
        Então a API deve retornar o status HTTP 200
        E a quantidade retornada do produto "P001" deve ser 5
        E o subtotal deve ser de R$ 299,50

    @API-07B @CA10
    Cenário: Rejeitar quantidade superior a cinco unidades
        Dado que o carrinho possui 6 unidades do produto "P001"
        Quando envio uma requisição POST para "/api/carrinho/calcular"
        Então a API deve retornar o status HTTP 422
        E o código de erro deve ser "QUANTIDADE_MAXIMA_EXCEDIDA"


    @API-08 @CA08
    Cenário: Manter frete grátis após aplicação do desconto
        Dado que o carrinho possui 2 unidades do produto "P005"
        E o subtotal antes do desconto é de R$ 200,00
        E o cupom informado é "BEMVINDO10"
        Quando envio uma requisição POST para "/api/carrinho/calcular"
        Então a API deve retornar o status HTTP 200
        E o desconto deve ser de R$ 20,00
        E o frete deve ser de R$ 0,00
        E o campo "freteGratis" deve ser true
        E o total deve ser de R$ 180,00


    @API-09
    Cenário: Confirmar pedido válido
        Dado que o cliente possui os seguintes dados válidos:
            | nome  | Maria Silva       |
            | email | maria@exemplo.com |
            | cep   | 01310-100         |
        E o pedido possui 1 unidade do produto "P005"
        E o cupom informado é "BEMVINDO10"
        Quando envio uma requisição POST para "/api/pedidos"
        Então a API deve retornar o status HTTP 201
        E o número do pedido deve seguir o padrão "VZ-" seguido de seis dígitos
        E o campo "criadoEm" deve conter uma data e hora válidas
        E o CEP retornado deve ser "01310100"
        E o subtotal deve ser de R$ 100,00
        E o desconto deve ser de R$ 10,00
        E o frete deve ser de R$ 19,90
        E o total deve ser de R$ 109,90


# {VAZIO} representa uma string vazia ("") no corpo JSON.
# Na automação, substituir o marcador {VAZIO} por "".
    @API-10
    Esquema do Cenário: Rejeitar pedido com dados inválidos
        Dado que o pedido possui 1 unidade do produto "P001"
        E os demais dados do cliente são válidos
        E o campo "<campo>" do cliente possui o valor "<valor>"
        Quando envio uma requisição POST para "/api/pedidos"
        Então a API deve retornar o status HTTP 422
        E os detalhes em "campos" devem identificar o campo "<campo>" inválido
        E o código de erro deve ser "DADOS_INVALIDOS"

        Exemplos:
            | campo | valor      |
            | nome  | {VAZIO}    |
            | email | sem-arroba |
            | cep   | abc        |

    @API-11
    Cenário: Consultar produto existente
        Dado que o produto "P001" existe no catálogo
        Quando envio uma requisição GET para "/api/produtos/P001"
        Então a API deve retornar o status HTTP 200
        E o campo "id" deve ser "P001"
        E o campo "nome" deve ser "Camiseta Essencial"
        E o campo "preco" deve ser 59.9

    @API-12 @CA03 @CA04
    Esquema do Cenário: Rejeitar pedido com cupom inválido ou expirado 
        Dado que o pedido possui dados válidos do cliente
        E o cupom "VERAO2026" está expirado na data do teste
        E contém 1 unidade do produto "P001"
        E o cupom informado é "<cupom>"
        Quando envio uma requisição POST para "/api/pedidos"
        Então a API deve retornar o status HTTP 422
        E o código de erro deve ser "<codigo>"

        Exemplos:
            | cupom       | codigo         |
            | INVALIDO123 | CUPOM_INVALIDO |
            | VERAO2026   | CUPOM_EXPIRADO |

    @API-13
    Esquema do Cenário: Rejeitar itens inválidos no cálculo do carrinho
        Dado que o corpo da requisição contém o JSON '<json>'
        Quando envio uma requisição POST para "/api/carrinho/calcular"
        Então a API deve retornar o status HTTP 422
        E o código de erro deve ser "<codigo>"

        Exemplos:
            | json                                                                                 | codigo                 |
            | {}                                                                                   | ITENS_OBRIGATORIOS     |
            | {"itens":[]}                                                                         | ITENS_OBRIGATORIOS     |
            | {"itens":[{"quantidade":1}]}                                                         | ITEM_INVALIDO          |
            | {"itens":[{"produtoId":"P001","quantidade":0}]}                                      | QUANTIDADE_INVALIDA    |
            | {"itens":[{"produtoId":"P001","quantidade":-1}]}                                     | QUANTIDADE_INVALIDA    |
            | {"itens":[{"produtoId":"P001","quantidade":1.5}]}                                    | QUANTIDADE_INVALIDA    |
            | {"itens":[{"produtoId":"P001","quantidade":"texto"}]}                                | QUANTIDADE_INVALIDA    |
            | {"itens":[{"produtoId":"P001","quantidade":1},{"produtoId":"P001","quantidade":2}]}  | ITEM_DUPLICADO         |
            | {"itens":[{"produtoId":"P999","quantidade":1}]}                                      | PRODUTO_NAO_ENCONTRADO |

    @API-14
    Esquema do Cenário: Validar erros de rota e método HTTP
        Quando envio uma requisição "<metodo>" para "<rota>"
        Então a API deve retornar o status HTTP <status>
        E o código de erro deve ser "<codigo>"

        Exemplos:
            | metodo | rota                  | status | codigo                |
            | GET    | /api/rota-inexistente | 404    | ROTA_NAO_ENCONTRADA   |
            | POST   | /api/produtos         | 405    | METODO_NAO_PERMITIDO  |

    @API-15
    Esquema do Cenário: Rejeitar requisição com JSON malformado
        Dado que o corpo da requisição contém o JSON malformado '{"itens":'
        Quando envio uma requisição POST para "<rota>"
        Então a API deve retornar o status HTTP 400
        E o código de erro deve ser "JSON_INVALIDO"

        Exemplos:
            | rota                   |
            | /api/carrinho/calcular |
            | /api/pedidos           |