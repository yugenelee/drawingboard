module Api
  module Payment
    class EntityApi < Grape::API
      extend Api::Base

      crud :payment
      crud :priceplan
      crud :event
      crud :review

    end
  end
end