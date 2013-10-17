class Service
  include Mongoid::Document
  include Mongoid::Timestamps
  include Includable::Serializer

  field :name
  field :display_name

  has_many :request_for_quote_categories
  has_many :providers
end