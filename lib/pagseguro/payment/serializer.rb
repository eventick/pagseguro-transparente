module PagSeguro
  class Payment
    class Serializer
      # The payment request that will be serialized.
      attr_reader :payment

      def initialize(payment)
        @payment = payment
      end

      def to_params
        raise InvalidTransaction, payment.errors.messages unless payment.valid?

        params[:email] = PagSeguro.email
        params[:token] = PagSeguro.token


        params[:notificationURL] = payment.notification_url
        params[:currency] = payment.currency
        params[:paymentMethod] = payment.payment_method
        params[:paymentMode] = payment.payment_mode
        params[:reference] = payment.reference
        params[:extraAmount] = payment.extra_amount

        payment.items.each.with_index(1) do |item, index|
          serialize_item(item, index)
        end

        serialize_sender(payment.sender)
        serialize_bank(payment.bank)
        serialize_credit_card(payment.credit_card)
        serialize_shipping(payment.shipping)


        params[:receiverEmail] = payment.receiver_email if payment.receiver_email

        params.delete_if {|key, value| value.nil? }

        params
      end

      private
      def params
        @params ||= {}
      end

      def serialize_shipping(shipping)
        return unless shipping
        raise InvalidShipping, shipping.errors.messages unless shipping.valid?

        params[:shippingType] = shipping.type_id
        params[:shippingCost] = to_amount(shipping.cost)

        serialize_address_shipping(shipping.address)
      end

      def serialize_item(item, index)
        return unless item
        raise InvalidItem, item.errors.messages unless item.valid?

        params["itemId#{index}".to_sym] = item.id
        params["itemDescription#{index}".to_sym] = item.description
        params["itemAmount#{index}".to_sym] = to_amount(item.amount)
        params["itemQuantity#{index}".to_sym] = item.quantity
      end

      def serialize_sender(sender)
        return unless sender
        raise InvalidSender, sender.errors.messages unless sender.valid?

        params[:senderName] = sender.name
        params[:senderCPF] = sender.document.value
        params[:senderEmail] =  sender.email
        params[:senderHash] =  sender.hash_id

        serialize_phone(sender.phone)
      end

      def serialize_phone(phone)
        return unless phone
        raise InvalidPhone, phone.errors.messages unless phone.valid?

        params[:senderAreaCode] = phone.area_code
        params[:senderPhone] = phone.number
      end

      def serialize_bank(bank)
        return unless bank
        raise InvalidBank, bank.errors.messages unless bank.valid?

        params[:bankName] = bank.name
      end

      def serialize_credit_card(credit_card)
        return unless credit_card
        raise InvalidCreditCard, credit_card.errors.messages unless credit_card.valid?

        params[:creditCardToken] = credit_card.token

        serialize_installment(credit_card.installment)
        serialize_holder(credit_card.holder)
        serialize_address(credit_card.billing_address)
      end


      def serialize_installment(installment)
        return unless installment
        raise InvalidInstallment, installment.errors.messages unless installment.valid?

        params[:installmentQuantity] = installment.quantity
        params[:installmentValue] = to_amount(installment.value)
      end

      def serialize_holder(holder)
        return unless holder
        raise InvalidHolder, holder.errors.messages unless holder.valid?

        params[:creditCardHolderName] = holder.name
        params[:creditCardHolderCPF] = holder.document.value
        params[:creditCardHolderBirthDate] = holder.birthdate
        params[:creditCardHolderAreaCode] = holder.phone.area_code
        params[:creditCardHolderPhone] = holder.phone.number
      end

      def serialize_address_shipping(address)
        return unless address
        raise InvalidAddress, address.errors.messages unless address.valid?

        params[:shippingAddressCountry] = address.country
        params[:shippingAddressState] = address.state
        params[:shippingAddressCity] = address.city
        params[:shippingAddressPostalCode] = address.postal_code
        params[:shippingAddressDistrict] = address.district
        params[:shippingAddressStreet] = address.street
        params[:shippingAddressNumber] = address.number
        params[:shippingAddressComplement] = address.complement
      end

      def serialize_address(address)
        return unless address
        raise InvalidAddress, address.errors.messages unless address.valid?

        params[:billingAddressCountry] = address.country
        params[:billingAddressState] = address.state
        params[:billingAddressCity] = address.city
        params[:billingAddressPostalCode] = address.postal_code
        params[:billingAddressDistrict] = address.district
        params[:billingAddressStreet] = address.street
        params[:billingAddressNumber] = address.number
        params[:billingAddressComplement] = address.complement
      end

      def to_amount(amount)
        "%.2f" % BigDecimal(amount.to_s).round(2).to_s("F") if amount
      end
    end
  end
end
