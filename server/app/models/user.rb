class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  ACCOUNT_ACTIVE = 'active'
  ACCOUNT_BLOCKED = 'blocked'
  PASSWORD_STUB = 'justapasswordstub'

  has_secure_password
  embeds_one :session
  embeds_many :email_sessions
  embeds_many :notifications
  has_many :auth_accounts
  field :email
  field :first_name
  field :last_name
  field :phone
  field :location, default: 'Singapore'
  field :photo_url
  field :password_digest
  field :has_password, type: Boolean, default: false
  field :email_confirmed, type: Boolean, default: false
  field :account_status, default: ACCOUNT_ACTIVE

  validates_presence_of :has_password, :first_name, :last_name

  def user_type; self._type end
  def active?; self.account_status == ACCOUNT_ACTIVE end
  def blocked?; self.account_status == ACCOUNT_BLOCKED end
  def unread_notifications; notifications.where(read: false).order_by('created_at DESC') end

  def as_json_options(options={})
    # val must be array!
    preset_options = {except: [:password_digest, :session, :email_sessions], include: [:auth_accounts],
                      methods: [:user_type, :unread_notifications]}
    if defined?(super)
      super(preset_options).each do |key,val|
        if options.has_key?(key)
          options[key] = (val.to_set.merge options[key]).to_a
        else
          options[key] = val
        end
      end
    else
      preset_options.each do |key,val|
        if options.has_key?(key)
          options[key] = (val.to_set.merge options[key]).to_a
        else
          options[key] = val
        end
      end
    end
    options
  end
  def as_json(options={})
    super as_json_options(options)
  end
end