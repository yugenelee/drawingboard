module Api
  module Common
    class MailingApi < Grape::API
      extend Api::Base

      resources 'mailer' do
        desc 'Contact Us'
        params do
          requires :form_values
        end
        post 'contact_us' do
          begin
            CommonServices::MailingService.contact_us(params[:form_values])
          rescue AccountServices::Exceptions::Exception => e
            status(400)
            {
                message: e.message
            }
          end
        end
      end ### end resource

    end
  end
end