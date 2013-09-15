class ProviderSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :address,
             :map_address,
             :browse_description,
             :profile_description,
             :status

  has_many :provider_pictures
  has_many :services

end
