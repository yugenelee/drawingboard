module PlatformServices
  class Base
    class << self
      def raise!(message)
        raise PlatformServices::Exceptions::Exception, message
      end
    end
  end
end