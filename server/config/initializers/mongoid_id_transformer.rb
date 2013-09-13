# encoding: utf-8
class Moped::BSON::ObjectId
  def as_json(options = nil)
    #{ "$oid" => to_s }
    to_s
  end
  def to_xml(options = nil)
    ActiveSupport::XmlMini.to_tag(options[:root], self.to_s, options)
  end
end

module ActiveSupport::JSON::Encoding
  class Encoder
    def encode(value, use_options = true)
      if value == "_id"
        value = "id"
      end
      check_for_circular_references(value) do
        jsonified = use_options ? value.as_json(options_for(value)) : value.as_json
        jsonified.encode_json(self)
      end
    end
  end
end