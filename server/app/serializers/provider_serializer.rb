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


class ProviderSerializer < ActiveModel::Serializer
  attributes :id,
             :name,
             :address,
             :map_address,
             :browse_description,
             :profile_description,
             :overall_rating,
             :status

  has_many :provider_pictures
  has_many :reviews, serializer: ReviewForProviderSerializer
  has_many :services

end
