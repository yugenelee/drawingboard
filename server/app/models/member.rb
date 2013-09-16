class Member < User
  include Includable::Serializer

  field :phone
  field :mobile
  has_many :events

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

end
