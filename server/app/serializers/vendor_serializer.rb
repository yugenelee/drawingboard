class ProviderForVendorSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :map_address,
             :map_lat,
             :map_lng,
             :expiry,
             :browse_description,
             :profile_description,
             :overall_rating,
             :created_at,
             :updated_at,
             :status

  has_many :provider_pictures
  #has_many :services
  has_one :service
  has_one :priceplan
end

class VendorSerializer < ActiveModel::Serializer
  attributes :id,
             :_type,
             :user_type,
             :first_name,
             :last_name,
             :email,
             :has_password,
             :email_confirmed,
             :account_status,
             :role,
             :phone,
             :mobile,
             :acra_no,
             :mailing_address,
             :questions,
             :last_login,
             :created_at,
             :updated_at

  has_many :providers, serializer: ProviderForVendorSerializer
end
