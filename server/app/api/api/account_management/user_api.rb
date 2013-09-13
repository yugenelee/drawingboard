module Api
  module AccountManagement
    class UserApi < Grape::API
      extend Api::Base

      crud :user
      crud :employer
      crud :freelancer

      end
    end
  end