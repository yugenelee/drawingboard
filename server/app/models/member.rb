class Member < User
  include Includable::Serializer

  field :phone
  field :mobile
  field :reached_by
  has_many :events
  has_many :reviews, inverse_of: :reviewer
  #has_and_belongs_to_many :votes, inverse_of: :voters

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  def upcoming_events
    self.events.gt(date: Date.today)
  end

  def past_events
    self.events.lte(date: Date.today)
  end

  def reviews_wrote
    self.reviews.count
  end

end
