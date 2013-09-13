module Api
  module AccountManagement
    class ServicesApi < Grape::API
      extend Api::Base

      resources 'users' do

        desc 'Activate User from Email Link'
        params do
          requires :token
        end
        get ':user_id/activate_with_token' do
          ip_address = request.ip.to_s
          begin
            AccountServices::EmailSessionService.perform_operation(params[:user_id], params[:token], ip_address)
          rescue AccountServices::Exceptions::Exception => e
            status(400)
            {
                message: e.message
            }
          end
        end

        desc 'Reset User Password from Email Link'
        params do
          requires :token
          requires :new_password
        end
        post ':user_id/reset_password_with_token' do
          ip_address = request.ip.to_s
          begin
            payload = {
                new_password: params[:new_password]
            }
            AccountServices::EmailSessionService.perform_operation(params[:user_id], params[:token], ip_address, payload)
          rescue AccountServices::Exceptions::Exception => e
            status(400)
            {
                message: e.message
            }
          end
        end

        desc 'Clear read notifications'
        post ':user_id/clear_notifications' do
          begin
            AccountServices::UserService.clear_notifications(params[:user_id])
          rescue AccountServices::Exceptions::Exception => e
            status(400)
            {
                message: e.message
            }
          end
        end

      end

    end
  end
end