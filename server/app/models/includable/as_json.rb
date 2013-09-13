module Includable
  module AsJson

    def self.included(base)
      define_singleton_method :expose_attrs do |attrs|
        if self.new.respond_to?(:as_json_options)
          alias_method :as_json_options_original, :as_json_options
          define_method :as_json_options do |options|
            # val must be array!
            preset_options = attrs
            as_json_options_original(preset_options).each do |key,val|
              if options.has_key?(key)
                options[key] = (val.to_set.merge options[key]).to_a
              else
                options[key] = val
              end
            end
            options
          end
        else
          define_method :as_json_options do |options|
            preset_options = attrs
            preset_options.each do |key,val|
              if options.has_key?(key)
                options[key] = (val.to_set.merge options[key]).to_a
              else
                options[key] = val
              end
            end
            options
          end
        end

        alias_method :as_json_original, :as_json
        define_method :as_json do |options={}|
          as_json_original as_json_options(options)
        end
      end # after define_singleton_method
    end

  end
end