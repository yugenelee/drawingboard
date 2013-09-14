class ProviderPicture
  include Mongoid::Document
  include Mongoid::Timestamps

  field :url
  field :thumb_url
  field :avatar_url

  embedded_in :provider

end