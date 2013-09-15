module Includable
  module Serializer

    def as_json(options={})
      serializer = self.class.name + 'Serializer'
      p serializer
      if serializer.safe_constantize
        p "===================="
        p "YES!!!!!!!!!!!!!"
        p "===================="
        serializer.constantize.new(self).as_json(options)
      else
        p "===================="
        p "NONONONO"
        p "===================="
        super(options)
      end
    end

  end
end