module PaymentServices
  class Base
    class << self
      def raise!(message)
        raise PaymentServices::Exceptions::Exception, message
      end
    end
  end
end