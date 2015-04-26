# PagSeguro Transparente

Gem para a utilização do novo [checkout transparente](https://pagseguro.uol.com.br/receba-pagamentos.jhtml#checkout-transparent) do Pagseguro. Essa forma de checkout permite que a compra seja realizada completamente em sua loja. Até o momento, para ter acesso a esse novo checkout é necessário entrar em contato com o PagSeguro para ter acesso a documentação.

[![Build Status](https://travis-ci.org/eventick/pagseguro-transparente.svg?branch=master)](https://travis-ci.org/eventick/pagseguro-transparente)
[![Coverage Status](https://coveralls.io/repos/eventick/pagseguro-transparente/badge.png)](https://coveralls.io/r/eventick/pagseguro-transparente)
[![Code Climate](https://codeclimate.com/github/eventick/pagseguro-transparente.png)](https://codeclimate.com/github/eventick/pagseguro-transparente)
[![Dependency Status](https://gemnasium.com/eventick/pagseguro-transparente.svg)](https://gemnasium.com/eventick/pagseguro-transparente)



## Sobre o PagSeguro

PagSeguro é a solução completa para pagamentos online, que garante a segurança de quem compra e de quem vende na web. Quem compra com PagSeguro tem a garantia de produto ou serviço entregue ou seu dinheiro de volta. Quem vende utilizando o serviço do PagSeguro tem o gerenciamento de risco de suas transações*. Quem integra lojas ao PagSeguro tem ferramentas, comissão e publicidade gratuita.

## Requisitos
Ruby >= 1.9.3
Rails >= 3.0

## Como usar

Adicione a biblioteca ao arquivo Gemfile:
~~~.ruby
gem "pagseguro-transparente", "~> 1.0.1"
~~~


Criar um initializer em config/initializer/pagseguro.rb
~~~.ruby
PagSeguro.configure do |config|
    config.email = "exemplo@pagseguro.com.br"
    config.token = "token válido"
end
~~~

## Etapas do checkout transparente
* Iniciar uma sessão de pagamento
* Obter os meios de pagamento*
* Obter a bandeira do cartão de crédito* (Cartão e crédito)
* Obter o token do cartão de crédito* (Cartão de crédito)
* Verificar as opções de parcelamento* (Cartão de crédito)
* Obter a identificação do comprador
* Efetuar o pagamento utilizando a API do Checkout Transparente

*Lib Javascript fornecidade pelo PagSeguro

## Iniciando uma nova sessão
~~~.ruby
pagseguro_session = PagSeguro::Session.new
pagseguro_session_id = pagseguro_session.create.id
~~~

## Criando uma transação

### Cartão de crédito
~~~.ruby
payment = PagSeguro::Payment.new(notification_url: 'www.eventick.com.br/notify', payment_method: 'creditCard', reference: '1')
~~~

#### Adiciando items
~~~.ruby
items = [PagSeguro::Item.new(id: 1, description: 'Ticket 1', amount: 2, quantity: 1), PagSeguro::Item.new(id: 2, description: 'Ticket 2', amount: 2, quantity: 1)]
payment.items = items
~~~

#### Adiciando comprador
~~~.ruby
phone = PagSeguro::Phone.new('11', '999999999')
document = PagSeguro::Document.new('111111111111')
sender = PagSeguro::Sender.new(email: 'cirdes@eventick.com.br', name: 'Cirdes Henrique', hash_id: identificao_do_comprador )
sender.phone = phone
sender.document = document
payment.sender = sender
~~~.ruby

####Adiciando endereço do comprador ou endereço de cobrança para cartão de crédito
~~~.ruby
address = PagSeguro::Address.new(postal_code: '01318002', street: 'AV BRIGADEIRO LUIS ANTONIO', number: '1892', complement: '112', district: 'Bela Vista', city: 'São Paulo', state: 'SP')
shipping = PagSeguro::Shipping.new
shipping.address = address
payment.shipping = shipping
~~~

#### Adiciando informações do cartão
~~~.ruby
credit_card = PagSeguro::CreditCard.new(creditcard_token)
credit_card.installment = PagSeguro::Installment.new(installment_quantity, installment_value)
credit_card.holder = PagSeguro::Holder.new(creditcard_name, creditcard_birthday)
document = PagSeguro::Document.new('111111111111')
credit_card.holder.document = document
phone = PagSeguro::Phone.new('11', '999999999')
credit_card.holder.phone = phone
address = PagSeguro::Address.new(postal_code: zipcode, street: street, number: number, complement: extra, district: neighbourhood, city: city, state: state )
credit_card.billing_address = mount_address
payment.credit_card = credit_card
~~~

#### Efetuando a transação
~~~.ruby
transaction = payment.transaction
~~~

Ao efetuar a transação, será retornado um objecto PagSeguro::Transaction que você poderá usar para atualizar o status da compra.

### Boleto
Com o retorno da transação você pegará a url para imprimir o boleto.
~~~.ruby
payment = PagSeguro::Payment.new(notification_url: 'www.eventick.com.br/notify', payment_method: 'boleto', reference: '1')
transaction = payment.transaction
transaction.payment_link
~~~

### Débito bancário
Você recebá a ulr para redirecionar o usuário ao banco.
Valores possívels para os bancos são: bradesco itau bancodobrasil banrisul hsbc
~~~.ruby
payment = PagSeguro::Payment.new(notification_url: 'www.eventick.com.br/notify', payment_method: 'eft', reference: '1')
payment.bank = PagSeguro::Bank.new('bradesco')

transaction = payment.transaction
transaction.payment_link
~~~

## Recebendo uma notificação de mundaça de status da transação
A documentação da API de Notificações podem ser encontrada no (site)[https://pagseguro.uol.com.br/v3/guia-de-integracao/api-de-notificacoes.html] do PagSeguro. As notificações utilizam a versão V3 da API do PagSeguro.

A notification_url informada como parâmetro da transação, irá receber um POST do PagSeguro informando que existe um atualização no status da transação. Para consultar o status da transação podemos utilizar o PagSeguroTransparent.

~~~.ruby
transaction = PagSeguro::Notification.new(notification_code, 'transaction').transaction
~~~

É possível verificar se a transação é uma transação válida, sem erros ou consultador o erros retornados pelo PagSeguro.
~~~.ruby
transaction.valid?
transaction.errors
~~~

## API de Consulta
A documentação da API de Consulta podem ser encontrada no (site)[https://pagseguro.uol.com.br/v3/guia-de-integracao/consulta-de-transacoes-por-codigo.html] do PagSeguro. As consultas utilizam a versão V3 da API do PagSeguro.

~~~.ruby
transaction = PagSeguro::Query.new(order_identifier).transaction
~~~

## PagSeguro::Transaction
A API de notificação, a API de consulta e de pagamento retornam um objeto da classe PagSeguro::Transaction. Transaction responde aos seguintes métodos:

~~~.ruby
date, last_event_date, code,reference, type, status, status_name, cancellation_source, payment_method, payment_link, gross_amount, discount_amount, escrow_end_date, net_amount, extra_amount, installment_count, items, sender, shipping, valid?, errors, fee_amount
~~~

## Suporte a múltipas contas
É possível utilizar mais de uma conta do PagSeguro ao efetuar suas transações. A utilização de uma segunda conta pode ser útil caso alguma das contas tenha alguma customização que fazem sentido para apenas alguns tipos de compras.

~~~.ruby
PagSeguro.configure do |config|
	config.email = 'email1@eventick.com.br'
	config.token = 'token1'
	config.alt_email = 'email2@eventick.com.br'
	config.alt_token = 'token2'
end
~~~

Em todos as chamadas a API é possível especificar qual conta deve ser utilizada. Caso o valor seja diferente de 'alternative' a conta principal será utilizada.

~~~.ruby
payment.transaction('alternative')
PagSeguro::Notification.new(notification_code, 'transaction').transaction('alternative')
~~~

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
