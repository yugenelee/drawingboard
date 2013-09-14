class Provider
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :address
  field :map_address
  field :browse_description
  field :profile_description

  belongs_to :vendor
  embeds_many :provider_pictures
  has_many :request_for_quotes
  has_and_belongs_to_many :services

end