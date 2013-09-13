module ProjectServices
  class Base
    class << self
      def raise!(message)
        raise ProjectServices::Exceptions::Exception, message
      end
    end
  end
end