module PagSeguro

  class InvalidTransaction < StandardError;   end

  class InvalidShipping < StandardError;   end

  class InvalidItem < StandardError;   end

  class InvalidSender < StandardError;   end

  class InvalidPhone < StandardError;   end

  class InvalidBank < StandardError;   end

  class InvalidCreditCard < StandardError;   end

  class InvalidInstallment < StandardError;   end

  class InvalidHolder < StandardError;   end

  class InvalidAddress < StandardError;   end
end
