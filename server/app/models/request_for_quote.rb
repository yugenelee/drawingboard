class RequestForQuote
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :provider
  belongs_to :event
  has_many :request_for_quote_categories
end