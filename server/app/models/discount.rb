class Discount
  include Mongoid::Document
  include Mongoid::Timestamps

  ACTIVE = 'active'
  SUSPENDED = 'suspended'

  field :code
  field :percentage, type: Integer
  field :expiry_date, type: DateTime
  field :description
  field :state, default: ACTIVE

  validates_uniqueness_of :code

  def suspended?
    self.state == SUSPENDED
  end

  def active?
    self.state == ACTIVE
  end
end