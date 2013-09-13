module AccountServices
  module DataAccessors

    def policy(auth_provider)
      policy = effective_policies[auth_provider.to_sym]
      raise! UNDEFINED_PROVIDER if policy.nil?
      policy
    end

    def auth(user_type, auth_id, auth_provider)
      auth = AuthAccount.where(auth_id: auth_id, auth_provider: auth_provider, user_type: user_type)
      raise! USER_NOT_FOUND if auth.blank?
      auth.first
    end

    def user(id)
      user = User.where(id: id)
      raise! USER_NOT_FOUND if user.blank?
      user.first
    end

    def email_session(user, token)
      session = EmailSession.get_session(user, token)
      raise! SESSION_NOT_FOUND if session.blank?
      raise! TOKEN_EXPIRED if session.expired?
      session
    end


  end
end