class Priceplan
  include Mongoid::Document
  include Mongoid::Timestamps

  BASIC_PLAN = 'Basic'
  BASIC_PLUS_PLAN = 'Basic Plus'
  PREMIUM_PLAN = 'Premium'

  BASIC_PLAN_CODE = 'basic'
  BASIC_PLUS_PLAN_CODE = 'basicplus'
  PREMIUM_PLAN_CODE = 'premium'

  field :code
  field :name
  field :price, type: BigDecimal
  field :description
end