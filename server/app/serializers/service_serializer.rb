class ProviderForServiceSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :address,
             :map_address,
             :map_lat,
             :map_lng,
             :browse_description,
             :profile_description,
             :status,
             :created_at,
             :updated_at

  has_many :provider_pictures
end

class ServiceSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :display_name

  has_many :providers, serializer: ProviderForServiceSerializer
end
