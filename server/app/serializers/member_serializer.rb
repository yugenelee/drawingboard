class MemberSerializer < ActiveModel::Serializer
  attributes :id,
             :_type,
             :user_type,
             :first_name,
             :last_name,
             :email,
             :has_password,
             :email_confirmed,
             :account_status

  has_many :events

end
