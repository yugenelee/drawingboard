class ReviewForProviderSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :content,
             :rating,
             :up_votes,
             :down_votes,
             :created_at,
             :updated_at

  has_one :reviewer
end

class VendorForProviderSerializer < ActiveModel::Serializer
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
             :created_at,
             :updated_at

end


class ProviderSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :address,
             :map_address,
             :map_lat,
             :map_lng,
             :browse_description,
             :profile_description,
             :overall_rating,
             :created_at,
             :updated_at,
             :status

  has_one :vendor, serializer: VendorForProviderSerializer
  has_many :provider_pictures
  has_many :reviews, serializer: ReviewForProviderSerializer
  has_many :services

end
