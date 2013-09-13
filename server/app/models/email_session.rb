# user of this email session creates this. for eg, confirm user, change password request.
# user later retrieve this session and inspect the purpose field to determine what action to take
# data field contains the data necessary to fulfill the purpose


class EmailSession
  include Mongoid::Document
  include Mongoid::Timestamps
  embedded_in :user
  field :token
  field :purpose
  field :data, type: Hash
  field :expires_at, type: DateTime

  validates_presence_of :token, :expires_at

  def expired?
    expires_at < DateTime.now
  end

  class << self
    def create_from_user!(user, purpose, data={})
      random_token = SecureRandom.uuid.gsub(/-/, '')
      user.email_sessions.where(purpose: purpose).destroy_all
      user.email_sessions.create! purpose: purpose, data: data, expires_at: DateTime.now.next_day, token: random_token
    end

    def get_session(user, token)
      sessions = user.email_sessions.where(token: token)
      sessions.blank?? nil : sessions.first
    end
  end
end
