module Api
  module AccountManagement
    class UserApi < Grape::API
      extend Api::Base

      crud :user
      crud :member
      crud :vendor

      end
    end
  end