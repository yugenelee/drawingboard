module CommonServices
  class Base
    class << self
      def raise!(message)
        raise CommonServices::Exceptions::Exception, message
      end
    end
  end
end