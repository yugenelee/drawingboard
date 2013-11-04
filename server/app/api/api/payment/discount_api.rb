module Api
  module Payment
    class DiscountApi < Grape::API
      extend Api::Base

      helpers do
        def handle_error(e, params, status_code=500)
          status(status_code)
          {
              message: e.message
          }
        end
      end

      resources 'discounts' do
        get 'is_valid_discount_code' do
          begin
            PaymentServices::Activities.is_valid_discount_code(params[:discount_code])
          rescue PaymentServices::Exceptions::Exception => e
            handle_error e, params, 404
          end
        end
      end # end paypal resource

      crud :discount

    end
  end
end