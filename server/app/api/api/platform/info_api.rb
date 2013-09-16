module Api
  module Platform
    class InfoApi < Grape::API
      extend Api::Base

      resources 'services' do
        params do
          requires :name
        end
        get 'get_from_name' do
          begin
            PlatformServices::Getters.service(params[:name])
          rescue PlatformServices::Exceptions::Exception => e
            handle_error e, params, 404
          end
        end
      end # end users resource

      crud :service
      crud :event

    end
  end
end