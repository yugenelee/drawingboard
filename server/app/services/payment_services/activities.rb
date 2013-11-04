module PaymentServices
  class Activities < Base

    self.extend PaymentServices::DataAccessors

    class << self

      def is_valid_discount_code(discount_code)
        discount = Discount.where(code: discount_code)
        discount = discount.empty?? nil : discount.first
        raise! DISCOUNT_CODE_NOT_FOUND if discount.nil?
        raise! DISCOUNT_CODE_EXPIRED if discount.suspended?
        discount
      end

      def paypal_link(provider_id, priceplan_id, discount_code, remote_ip, pp_return_url, pp_cancel_url)
        priceplan = priceplan(priceplan_id)
        begin
          discount = 100 - discount_from_code(discount_code).percentage
        rescue
          discount = 100
        end
        cents = (discount * priceplan.price).to_i
        payment = Payment.create! provider_id: provider_id,
                                  priceplan_id: priceplan_id,
                                  cents: cents,
                                  purpose: Payment::NEW_PLAN,
                                  ip_address: remote_ip,
                                  status: Payment::PAYMENT_PENDING
        payment_in_cents = payment.cents
        options = {}
        options[:ip] = remote_ip
        options[:return_url] = pp_return_url
        options[:cancel_return_url] = pp_cancel_url
        options[:order_id] = payment.id
        options[:currency] = 'SGD'
        # subtotal, shipping, handling and tax must sum up to the orders total value
        # subtotal must be the sum of all amounts of all items
        options[:subtotal] = payment_in_cents
        options[:shipping] = 0
        options[:handling] = 0
        options[:tax] = 0
        options[:items] = []
        options[:items] << {
            name: priceplan.description,          # description
            quantity: 1,         # quantity
            amount: payment_in_cents  # unit price
        }
        credentials = {
            :login => "felixs_1313060608_biz_api1.gmail.com",
            :password => "1313060648",
            :signature => "A6ZwSplvM51wI9C4jWCOqGE.tovkAXnUkzrTM7uWjWFnEaZsFvZ3XjwK"
        }
        ActiveMerchant::Billing::Base.mode = :test
        gateway = ActiveMerchant::Billing::PaypalExpressGateway.new(credentials)
        response = gateway.setup_purchase(payment_in_cents,options)
        if response.success?
          payment.pp_token = response.token
          response = {
              status: SUCCESS,
              paypal_url: gateway.redirect_url_for(response.token)
          }
        else
          payment.error_message = 'Unable to setup paypal express api.'
          response = {
              status: FAILED
          }
        end
        payment.save!
        response
      end

      def perform_payment(token, payer_id)
        payment = payment_from_token(token)
        if payment.paid?
          {
              status: 'ALREADY_PAID'
          }
        else
          payment.payer_id = payer_id #params[:PayerID]
          payment_in_cents = payment.cents
          credentials = {
              :login => "felixs_1313060608_biz_api1.gmail.com",
              :password => "1313060648",
              :signature => "A6ZwSplvM51wI9C4jWCOqGE.tovkAXnUkzrTM7uWjWFnEaZsFvZ3XjwK"
          }
          ActiveMerchant::Billing::Base.mode = :test
          gateway = ActiveMerchant::Billing::PaypalExpressGateway.new(credentials)
          response = gateway.purchase(payment_in_cents,
                                      :ip => payment.ip_address,
                                      :token => token,
                                      :payer_id => payer_id,
                                      :currency => 'SGD'
          )
          p "================"
          p response
          p "================"
          if response.success?
            payment.paid_at = Time.now
            payment.status = Payment::PAYMENT_SUCCESS
            payment.save!
            provider = payment.provider
            provider.priceplan = payment.priceplan
            provider.status = Provider::PENDING_APPROVAL
            provider.expiry = Date.today.next_year
            provider.save!
            {
                status: 'PAYMENT_SUCCESS',
                provider: provider.as_json
            }
          else
            payment.status = Payment::PAYMENT_FAILED
            payment.save!
            {
                status: 'PAYMENT_FAILED',
                error: 'Payment failed. You have not been charged.'
            }
          end
        end
      end

    end

  end
end