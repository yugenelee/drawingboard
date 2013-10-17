class RequestForQuote
  include Mongoid::Document
  include Mongoid::Timestamps

  belongs_to :provider
  belongs_to :event
  field :question  
end