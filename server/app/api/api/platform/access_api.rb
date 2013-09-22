module Api
  module Platform
    class AccessApi < Grape::API
      extend Api::Base

      helpers do
        def handle_error(e, params, status_code=500)
          status(status_code)
          {
              message: e.message
          }
        end
      end
      
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
      end # end events resource

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
      end # end services resource

      resources 'providers' do
        put ':id/approve' do
          begin
            provider = Provider.find params[:id]
            provider.status = Provider::APPROVED
            provider.save!
          rescue PlatformServices::Exceptions::Exception => e
            handle_error e, params, 404
          end
        end
      end # end services resource

      crud :provider
      crud :service
      crud :event
      crud :review

    end
  end
end