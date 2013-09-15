module Api
  module Platform
    class AccessApi < Grape::API
      extend Api::Base

      crud :provider

    end
  end
end