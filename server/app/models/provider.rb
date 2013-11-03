class Provider
  include Mongoid::Document
  include Mongoid::Timestamps
  include Includable::Serializer

  PENDING_PAYMENT = 'Pending Payment'
  PENDING_APPROVAL = 'Pending Approval'
  APPROVED = 'Approved'

  field :name
  field :map_address
  field :map_lat
  field :map_lng
  field :expiry, type: Date
  field :browse_description
  field :profile_description
  field :overall_rating, default: 0
  field :status, default: PENDING_PAYMENT
  #field :status, default: APPROVED

  belongs_to :vendor
  belongs_to :priceplan
  embeds_many :provider_pictures
  has_many :reviews
  has_many :request_for_quotes
  #has_and_belongs_to_many :services
  belongs_to :service

  accepts_nested_attributes_for :provider_pictures, reject_if: :all_blank, allow_destroy: true

  validates :name, uniqueness: {scope: :vendor_id, message: 'already submitted another listing with the same name.'}
end