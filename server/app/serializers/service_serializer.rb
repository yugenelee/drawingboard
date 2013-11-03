class ProviderForServiceSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :map_address,
             :map_lat,
             :map_lng,
             :expiry,
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
