module CommonServices
  class MailingService < Base

    class << self

      def contact_us(name_value_hash_string)
        name_value_hash = ActiveSupport::JSON.decode name_value_hash_string
        CommonMailer.delay.contact_us(name_value_hash)
        {
            status: SUCCESS
        }
      end

    end

  end
end