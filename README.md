# PagSeguro Transparente

Gem para a utilização do novo checkout transparente do Pagseguro.

[![Build Status](https://travis-ci.org/eventick/pagseguro-transparente.svg?branch=master)](https://travis-ci.org/eventick/pagseguro-transparente)
[![Coverage Status](https://coveralls.io/repos/eventick/pagseguro-transparente/badge.png)](https://coveralls.io/r/eventick/pagseguro-transparente)
[![Code Climate](https://codeclimate.com/github/eventick/pagseguro-transparente.png)](https://codeclimate.com/github/eventick/pagseguro-transparente)
[![Dependency Status](https://gemnasium.com/eventick/pagseguro-transparente.svg)](https://gemnasium.com/eventick/pagseguro-transparente)



## Sobre o PagSeguro

PagSeguro é a solução completa para pagamentos online, que garante a segurança de quem compra e de quem vende na web. Quem compra com PagSeguro tem a garantia de produto ou serviço entregue ou seu dinheiro de volta. Quem vende utilizando o serviço do PagSeguro tem o gerenciamento de risco de suas transações*. Quem integra lojas ao PagSeguro tem ferramentas, comissão e publicidade gratuita.

## Requisitos
Ruby >= 1.9.3
Rails >= 3.0

##Como usar

Adicione a biblioteca ao arquivo Gemfile:
~~~.ruby
gem "pagseguro-transparente", "~> 0.0.1"
~~~
* Ainda não publicada, é preciso baixar direto do Github.

Criar um initializer em config/initializer/pagseguro.rb
~~~.ruby
PagSeguro.configure do |config|
    config.email = "exemplo@pagseguro.com.br"
    config.token = "token válido"
end
~~~

##Criando uma nova sessão
~~~.ruby
pagseguro_session = PagSeguro::Session.new
@pagseguro_session_id = pagseguro_session.create.id
~~~

##Criando uma transação
~~~.ruby
payment = PagSeguro::Payment.new(notification_url: 'www.eventick.com.br', payment_method: 'boleto', reference: '1')
items = [PagSeguro::Item.new(1, 'Ingresso Teste', 2, 1)]
payment.items = items


phone = PagSeguro::Phone.new('81', '97550129')
document = PagSeguro::Document.new('01735536300')

sender = PagSeguro::Sender.new(email: 'cirdes@gmail.com', name: 'Cirdes Henrique', hash_id:  )
sender.phone = phone
sender.document = document

payment.sender = sender

address = PagSeguro::Address.new(postal_code: '52050040', street: 'Rua Teles Junior', number: '475', complement: '301', district: 'rosarinho', city: 'Recife', state: 'PE')
shipping = PagSeguro::Shipping.new
shipping.address = address

payment.shipping = shipping

response = payment.register

response.payment_link
~~~

Você deve redirecionar o usário para a url retornada para compras com boleto e débito bancário.

This is a working in progress!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
