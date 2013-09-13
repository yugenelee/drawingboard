class Vendor < User

  field :role
  field :phone
  field :mobile
  field :acra_no
  field :mailing_address
  field :questions #if exists, send to admin

  has_many :providers

  validates :email, presence: true, uniqueness: true,
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}

  def _deny_fields; %W{} end

  def as_json_options(options={})
    # val must be array!
    exposed = [:_deny_fields]
    preset_options = {methods: exposed}
    if defined?(super)
      super(preset_options).each do |key,val|
        if options.has_key?(key)
          options[key] = (val.to_set.merge options[key]).to_a
        else
          options[key] = val
        end
      end
    else
      preset_options.each do |key,val|
        if options.has_key?(key)
          options[key] = (val.to_set.merge options[key]).to_a
        else
          options[key] = val
        end
      end
    end
    options
  end

  def as_json(options={})
    options = as_json_options(options)
    super options
  end
end
