module Api
  module Payment
    class PaypalApi < Grape::API
      extend Api::Base

      helpers do
        def handle_error(e, params, status_code=500)
          status(status_code)
          {
              message: e.message
          }
        end
      end

      resources 'payments' do
        get 'paypal_link' do
          begin
            ip_address = request.ip.to_s
            PaymentServices::Activities.paypal_link(params[:provider_id], params[:priceplan_id], params[:discount_code], ip_address, params[:pp_return_url], params[:pp_cancel_url])
          rescue PaymentServices::Exceptions::Exception => e
            handle_error e, params, 404
          end
        end

        post 'perform_payment' do
          begin
            PaymentServices::Activities.perform_payment(params[:token], params[:payer_id])
          rescue PaymentServices::Exceptions::Exception => e
            handle_error e, params, 404
          end
        end

      end # end paypal resource

    end
  end
end