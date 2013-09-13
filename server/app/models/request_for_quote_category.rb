class RequestForQuoteCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :request_for_quote
  belongs_to :service
  field :question


end