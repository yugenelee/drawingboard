module Api
  class Main < Grape::API

    version 'v1', using: :header, vendor: 'Grape API', cascade: false
    format :json

    helpers do
      def authorize!(*roles)
        auth = OpenStruct.new JSON.parse(headers['User-Authorization'])
        p auth.inspect
        error!('Forbidden', 403) unless roles.include?(auth.role)
        case auth.role
          when 'freelancer'
            #user = Freelancer.where(user_type: auth.user_type, username: auth.username).first
          default
            error!('Roles not implemented', 501)
        end
        if user.blank?
          error!('User cannot be found', 401)
        else
          error!('Invalid Password',401) unless user.authenticate(auth.password)
        end
      end
    end

    rescue_from :all do |e|
      Rails.logger.error "#{e.class}\n\n#{e.message}\n\n#{e.backtrace.join("\n")}"
      case e.class.to_s
        when 'Mongoid::Errors::DocumentNotFound'
          response_code = 404
        when 'Grape::Exceptions::Validation'
          response_code = 400
        else
          response_code = 500
      end
      Rack::Response.new(
          {message: e.message}.to_json,
          response_code,
          { 'Content-type' => 'application/json',
            'Access-Control-Allow-Origin' => '*',
            'Access-Control-Request-Method' => '*'
          }).finish
    end

    mount Api::Common::MailingApi
    mount Api::AccountManagement::AuthApi
    mount Api::AccountManagement::ServicesApi
    mount Api::AccountManagement::UserApi # ordering is important! because of users/:id and users/authenticate

    mount Api::ProjectManagement::ActivitiesApi
    mount Api::ProjectManagement::ProjectApi

    add_swagger_documentation(
        mount_path: 'apidocs',
        base_path: 'http://localhost:3000/api'
    )
  end
end