class Member < User
  include Includable::Serializer

  field :phone
  field :mobile
  has_many :events

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  def upcoming_events
    self.events.gt(date: Date.today)
  end

  def past_events
    self.events.lte(date: Date.today)
  end

end
