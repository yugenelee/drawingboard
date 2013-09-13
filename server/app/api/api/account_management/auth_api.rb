module Api
  module AccountManagement
    class AuthApi < Grape::API
      extend Api::Base

      helpers do
        def handle_error(e, params, status_code=401)
          case e.message
            when AccountServices::USER_NOT_FOUND
              status(status_code)
              {
                  message: 'User not found. Please register',
                  errors: [:email]
              }
            when AccountServices::UNDEFINED_PROVIDER
              status(status_code)
              {
                  message: "Connecting using #{params[:auth_provider]} is not supported at this moment."
              }
            when AccountServices::INVALID_PASSWORD_ON_LOGIN, AccountServices::PASSWORD_REQUIRED
              status(status_code)
              {
                  message: 'Invalid email or password.',
                  errors: [:password]
              }
            when AccountServices::USER_PENDING_CONFIRMATION
              status(status_code)
              {
                  message: 'Another email has been sent to activate your account.'
              }
            when AccountServices::USER_BLOCKED
              status(status_code)
              {
                  message: 'You account has been suspended.'
              }
            when AccountServices::ALREADY_REGISTERED
              status(status_code)
              {
                  message: 'You have already registered.',
                  errors: [:email]
              }
            else
              status(status_code)
              {
                  message: e.message
              }
          end
        end
      end

      resources 'users' do

        desc 'Get user from account. When client pass in auth provider&id, determine if the account exists'
        params do
          requires :auth_id
          requires :auth_provider
          requires :user_type
        end
        get 'get_from_account' do
          begin
            AccountServices::UserPolicy.get_user_from_account(params[:user_type], params[:auth_id], params[:auth_provider])
          rescue Account::Services::Exception => e
            handle_error e, params, 404
          end
        end

        desc 'Authenticate user'
        params do
          requires :auth_id
          requires :auth_provider
          requires :user_type
        end
        get 'authenticate' do
          begin
            ip_address = request.ip.to_s
            AccountServices::UserService.authenticate(params[:user_type], params[:auth_id], params[:auth_provider], ip_address, params[:password])
          rescue AccountServices::Exceptions::Exception => e
            handle_error e, params
          end
        end

        desc 'Authenticate user with token'
        params do
          requires :auth_id
          requires :auth_provider
          requires :token
          requires :user_type
        end
        get 'authenticate_with_token' do
          begin
            ip_address = request.ip.to_s
            AccountServices::UserService.authenticate_with_token(params[:user_type], params[:auth_id], params[:auth_provider], params[:token], ip_address)
          rescue AccountServices::Exceptions::Exception => e
            status(401)
            {
                message: 'You need to log in to access this page'
            }
          end

        end

        desc 'Register a user'
        params do
          requires :auth_id
          requires :auth_provider
          requires :email
          requires :user_type
        end
        post 'register' do
          begin
            AccountServices::UserService.register(params[:user_type], params[:auth_id], params[:auth_provider], params[:email], params[:password], params[:additional_fields])
          rescue AccountServices::Exceptions::Exception => e
            handle_error e, params
          end
        end

        desc 'Forgot Password'
        params do
          requires :user_type
          requires :auth_id
          requires :auth_provider
        end
        post 'forgot_password' do
          begin
            AccountServices::UserService.forgot_password(params[:user_type], params[:auth_id], params[:auth_provider])
          rescue AccountServices::Exceptions::Exception => e
            handle_error e, params
          end
        end

      end ## end resource

    end
  end
end