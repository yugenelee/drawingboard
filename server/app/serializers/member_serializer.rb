class ReviewForMemberSerializer < ActiveModel::Serializer
  attributes :id,
             :title,
             :content,
             :rating,
             :up_votes,
             :down_votes,
             :created_at,
             :updated_at
end


class MemberSerializer < ActiveModel::Serializer
  attributes :id,
             :_type,
             :user_type,
             :first_name,
             :last_name,
             :email,
             :has_password,
             :email_confirmed,
             :account_status,
             :phone,
             :mobile,
             :reviews_wrote,
             :created_at,
             :updated_at

  has_many :upcoming_events
  has_many :past_events
  has_many :reviews, serializer: ReviewForMemberSerializer
end
