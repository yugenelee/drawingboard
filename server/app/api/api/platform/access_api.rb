module Api
  module Platform
    class AccessApi < Grape::API
      extend Api::Base

      resources 'events' do
        post 'save_form' do
          begin
            PlatformServices::Activities.save_event_form params
          rescue PlatformServices::Exceptions::Exception => e
            handle_error e, params, 404
          end
        end

        post 'submit_form' do
          begin
            PlatformServices::Activities.submit_event_form params
          rescue PlatformServices::Exceptions::Exception => e
            handle_error e, params, 404
          end
        end
      end # end users resource

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

      crud :provider
      crud :service
      crud :event

    end
  end
end