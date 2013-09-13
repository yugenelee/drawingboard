class ProviderPicture
  include Mongoid::Document
  include Mongoid::Timestamps

  field :large_url
  field :thumbnail_url

  belongs_to :provider

end