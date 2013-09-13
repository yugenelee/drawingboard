class AuthAccount
  include Mongoid::Document
  include Mongoid::Timestamps
  belongs_to :user

  field :auth_id
  field :auth_provider
  field :user_type

  validates_presence_of :user, :auth_id, :auth_provider, :user_type
  validates_uniqueness_of :auth_id, scope: [:auth_provider, :user_type, :user_id]
end