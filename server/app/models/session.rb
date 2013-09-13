class Session
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user
  field :ip_address
  field :token
  field :expires_at, type: DateTime

  validates_presence_of :ip_address, :token, :expires_at

  def expired?
    expires_at < DateTime.now
  end

  class << self
    def create_from_user!(user, ip_address)
      random_token = SecureRandom.uuid.gsub(/-/, '')
      user.session.destroy unless user.session.blank?
      user.create_session ip_address: ip_address, expires_at: DateTime.now.next_day, token: random_token
    end
  end

end
