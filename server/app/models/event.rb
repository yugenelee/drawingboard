class Event
  include Mongoid::Document
  include Mongoid::Timestamps

  UPCOMING = 'Upcoming'
  PAST = 'Past'

  field :name
  field :date, type: Date
  field :starts_at
  field :ends_at
  field :number_of_guests, type: Integer
  field :location
  field :vision
  field :preferred_contact_method
  field :preferred_contact_number
  field :alternate_contact_number
  field :contact_email
  field :status, default: UPCOMING

  belongs_to :member
  has_many :request_for_quotes

end