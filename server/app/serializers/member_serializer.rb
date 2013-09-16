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
             :mobile

  has_many :upcoming_events
  has_many :past_events

end
