class Notification
  include Mongoid::Document
  include Mongoid::Timestamps

  embedded_in :user
  field :read, type: Boolean
  field :message

end