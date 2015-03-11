module PagSeguro
  class Transaction
    class CreditorFees
      attr_accessor :creditor_fees

      def initialize(creditor_fees)
        @creditor_fees = creditor_fees
      end

      def installment_fee_amount
        @installment_fee_amount ||= creditor_fees['installmentFeeAmount'].to_f
      end

      def intermediation_rate_amount
        @intermediation_rate_amount ||= creditor_fees['intermediationRateAmount'].to_f
      end

      def intermediation_fee_amount
        @intermediation_fee_amount ||= creditor_fees['intermediationFeeAmount'].to_f
      end

      def fee_amount
        @fee_amount ||= installment_fee_amount + intermediation_rate_amount + intermediation_fee_amount
      end
    end
  end
end
