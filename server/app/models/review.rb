class Review
  include Mongoid::Document
  include Mongoid::Timestamps
  include Includable::Serializer

  field :title
  field :content
  field :rating
  field :up_votes
  field :down_votes

  belongs_to :provider
  belongs_to :reviewer, class_name: 'Member', inverse_of: :reviews
  has_and_belongs_to_many :voters, class_name: 'Member', inverse_of: :votes

  after_save :update_provider_rating

  def update_provider_rating
    provider.overall_rating = (provider.overall_rating.to_f * provider.reviews.length.to_f + self.rating.to_f) / (provider.reviews.length+1).to_f
    provider.save!
  end
end