class ReviewSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :content,
             :rating,
             :up_votes,
             :down_votes,
             :created_at,
             :updated_at

  has_one :reviewer
  has_one :provider

end
