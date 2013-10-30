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

  has_many :providers
end
