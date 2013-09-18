module Api
  module AccountManagement
    class UserApi < Grape::API
      extend Api::Base

      crud :user
      crud :member
      crud :vendor
      crud :admin

      end
    end
  end