module PagSeguro
  class Payment
    class Serializer
      # The payment request that will be serialized.
      attr_reader :payment#, :params

      def initialize(payment)
        @payment = payment
        @params = {}
      end

      def to_params
        params[:notificationURL] = payment.notification_url
        params[:currency] = payment.currency
        params[:paymentMethod] = payment.payment_method
        params[:paymentMode] = payment.payment_mode
        params[:reference] = payment.reference
        params[:extraAmount] = payment.extra_amount
        params[:noInterestInstallmentQuantity] = payment.max_installment_no_interest

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

        params[:shippingType] = shipping.type_id
        params[:shippingCost] = to_amount(shipping.cost)

        serialize_address_shipping(shipping.address)
      end

      def serialize_item(item, index)
        return unless item

        params["itemId#{index}".to_sym] = item.id
        params["itemDescription#{index}".to_sym] = item.description
        params["itemAmount#{index}".to_sym] = to_amount(item.amount)
        params["itemQuantity#{index}".to_sym] = item.quantity
      end

      def serialize_sender(sender)
        return unless sender

        params[:senderName] = sender.name
        params[:senderEmail] =  sender.email
        params[:senderHash] =  sender.hash_id

        serialize_document(sender.document)
        serialize_phone(sender.phone)
      end

      def serialize_document(document)
        if document.cpf?
          params[:senderCPF] = document.value
        else
          params[:senderCNPJ] = document.value
        end
      end

      def serialize_phone(phone)
        return unless phone

        params[:senderAreaCode] = phone.area_code
        params[:senderPhone] = phone.number
      end


      def serialize_bank(bank)
        return unless bank

        params[:bankName] = bank.name
      end

      def serialize_credit_card(credit_card)
        return unless credit_card

        params[:creditCardToken] = credit_card.token

        serialize_installment(credit_card.installment)
        serialize_holder(credit_card.holder)
        serialize_address(credit_card.billing_address)
      end


      def serialize_installment(installment)
        return unless installment

        params[:installmentQuantity] = installment.quantity
        params[:installmentValue] = to_amount(installment.value)
      end

      def serialize_holder(holder)
        return unless holder

        params[:creditCardHolderName] = holder.name
        params[:creditCardHolderCPF] = holder.document.value
        params[:creditCardHolderBirthDate] = holder.birthdate.strftime("%d/%m/%Y") if holder.birthdate
        params[:creditCardHolderAreaCode] = holder.phone.area_code
        params[:creditCardHolderPhone] = holder.phone.number
      end

      def serialize_address_shipping(address)
        return unless address

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
