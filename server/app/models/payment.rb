class Payment
  include Mongoid::Document
  include Mongoid::Timestamps

  PAYMENT_FAILED = 'PAYMENT_FAILED'
  PAYMENT_PENDING = 'PAYMENT_PENDING'
  PAYMENT_SUCCESS = 'PAYMENT_SUCCESS'

  NEW_PLAN = 'NEW_PLAN'
  UPGRADE_PLAN = 'UPGRADE_PLAN'

  field :pp_token
  field :ip_address
  field :payer_id
  field :paid_at
  field :purpose # upgrade? new plan?
  field :status
  field :error_message
  field :cents

  belongs_to :provider
  belongs_to :priceplan

  def paid?
    not self.paid_at.nil?
  end
end