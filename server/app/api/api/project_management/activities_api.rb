module Api
  module ProjectManagement
    class ActivitiesApi < Grape::API
      extend Api::Base

      resources 'projects' do

        desc 'Add bidder'
        params do
          requires :user_id
        end
        post ':id/add_bidder' do
          begin
            ProjectServices::Activities.add_bidder params[:id], params[:user_id]
          rescue ProjectServices::Exceptions::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

        desc 'Add offer'
        params do
          requires :user_id
        end
        post ':id/add_offer' do
          begin
            ProjectServices::Activities.add_offer params[:id], params[:user_id]
          rescue ProjectServices::Exceptions::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

        desc 'Accept offer'
        params do
          requires :user_id
        end
        post ':id/accept_offer' do
          begin
            ProjectServices::Activities.accept_offer params[:id], params[:user_id]
          rescue ProjectServices::Exceptions::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

        desc 'Accept bid'
        params do
          requires :user_id
        end
        post ':id/accept_bid' do
          begin
            ProjectServices::Activities.accept_bid params[:id], params[:user_id]
          rescue ProjectServices::Exceptions::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

        desc 'Mark as complete'
        put ':id/mark_as_complete' do
          begin
            ProjectServices::Activities.mark_as_complete params[:id]
          rescue ProjectServices::Exceptions::Exception => e
            status(404)
            {
                message: e.message
            }
          end
        end

      end

    end
  end
end