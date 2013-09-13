class Service
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :display_name

  has_many :request_for_quote_categories
  has_and_belongs_to_many :providers

  def self.list_by_name
    list = {}
    Service.all.each do |sc|
      list[sc.name] = sc
    end
  end
end