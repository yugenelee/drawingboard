module Includable
  module Serializer

    def as_json(options={})
      serializer = self.class.name + 'Serializer'
      p serializer
      if serializer.safe_constantize
        serializer.constantize.new(self).as_json(options)
      else
        super(options)
      end
    end

  end
end