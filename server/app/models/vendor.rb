class Vendor < User
  include Includable::Serializer

  field :role
  field :phone
  field :mobile
  field :acra_no
  field :mailing_address
  field :questions #if exists, send to admin

  has_many :providers

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

end
