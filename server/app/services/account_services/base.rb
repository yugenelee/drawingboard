module AccountServices
  class Base
    class << self
      def raise!(message)
        raise AccountServices::Exceptions::Exception, message
      end

      def effective_policies
        policies = {}
        PROVIDER_POLICIES.each do |provider, keypair|
          policies[provider] = POLICIES.dup
          keypair.each do |key, value|
            policies[provider][key] = value
          end
        end
        policies
      end
    end
  end
end