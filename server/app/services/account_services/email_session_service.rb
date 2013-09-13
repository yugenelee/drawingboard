module AccountServices
  class EmailSessionService < Base

    self.extend AccountServices::DataAccessors

    class << self
      def send_confirmation_email(user)
        session = EmailSession.create_from_user!(user, ACTIVATE_USER)
        UserMailer.activate_account(user, session.token).deliver!
      end

      def request_password_reset(user)
        session = EmailSession.create_from_user!(user, RESET_PASSWORD)
        UserMailer.reset_password(user, session.token).deliver!
      end

      def perform_operation(user_id, token, ip_address, payload={})
        user = user(user_id)
        session = email_session(user, token)
        case session.purpose
          when ACTIVATE_USER
            result = activate_user(user, ip_address)
          when RESET_PASSWORD
            new_password = payload[:new_password]
            raise! PAYLOAD_NOT_FOUND if new_password.blank?
            result = reset_password(user, new_password)
          else
            raise! PURPOSE_NOT_FOUND
        end
        session.destroy
        result
      end

      protected

      def activate_user(user, ip_address)
        raise! EMAIL_ALREADY_CONFIRMED if user.email_confirmed
        user.email_confirmed = true
        user.save!
        session = Session.create_from_user! user, ip_address
        {
            user_type: user.user_type,
            user: user.as_json,
            auth_id: user.auth_accounts[0].auth_id,
            auth_provider: user.auth_accounts[0].auth_provider,
            token: session.token
        }
      end

      def reset_password(user, new_password)
        user.password = new_password
        user.password_confirmation = new_password
        begin
          user.save!
          {
              status: SUCCESS
          }
        rescue Exception => e
          status(400)
          {
            status: FAILED,
            message: e.message
          }
        end
      end

    end

  end
end
