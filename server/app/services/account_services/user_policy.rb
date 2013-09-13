module AccountServices
  class UserPolicy < Base

    self.extend AccountServices::DataAccessors

    class << self
      def get_user_from_account(user_type, auth_id, auth_provider)
        auth(user_type, auth_id, auth_provider).user.as_json
      end
    end

  end
end
