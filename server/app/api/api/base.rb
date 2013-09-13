module Api
  module Base

    def count(resource_sym)
      resource_name = resource_sym.to_s
      plural_resource_name = resource_name.pluralize
      entity_class = resource_name.camelize.constantize
      resources plural_resource_name do
        desc "Get #{plural_resource_name} count"
        params do
          optional :search, desc: 'Full text search'
          optional :conditions, desc: 'A JSON formatted string of conditions'
        end
        get 'count' do
          search = params[:search].blank?? '' : params[:search]
          conditions = params[:conditions].blank?? {} : ActiveSupport::JSON.decode(params[:conditions]).symbolize_keys
          if search.blank?
            entity_class.where(conditions).count
          else
            entity_class.full_text_search(search).where(conditions).count
          end
        end
      end
    end

    def all(resource_sym)
      resource_name = resource_sym.to_s
      plural_resource_name = resource_name.pluralize
      entity_class = resource_name.camelize.constantize
      resources plural_resource_name do
        desc "Get all #{plural_resource_name}"
        params do
          optional :search, desc: 'Full text search'
          optional :conditions, desc: 'A JSON formatted string of conditions'
          optional :order, desc: 'order by command such as "created_at DESC", multiple order by can be written as "created_at DESC, name ASC"'
          optional :limit
          optional :offset
          optional :page
          optional :per_page
          optional :includes, desc: 'a json string of what to include, check \'http://apidock.com/rails/ActiveModel/Serializers/JSON/as_json\''
        end
        get do
          search = params[:search].blank?? '' : params[:search]
          order = params[:order].blank?? 'created_at DESC' : params[:order]
          conditions = params[:conditions].blank?? {} : ActiveSupport::JSON.decode(params[:conditions]).symbolize_keys
          limit = params[:limit].blank?? 100 : params[:limit]
          offset = params[:offset].blank?? 0 : params[:offset]
          page = params[:page].blank?? 1 : params[:page]
          per_page = params[:per_page].blank?? 100 : params[:per_page]
          includes = params[:includes].blank?? {} : ActiveSupport::JSON.decode(params[:includes]).symbolize_keys
          if search.blank?
            entity_class.where(conditions).order_by(order).limit(limit).skip(offset).paginate(page: page, per_page: per_page).as_json includes
          else
            entity_class.full_text_search(search).where(conditions).order_by(order).limit(limit).skip(offset).paginate(page: page, per_page: per_page).as_json includes
          end
        end
      end
    end

    def find(resource_sym)
      resource_name = resource_sym.to_s
      plural_resource_name = resource_name.pluralize
      entity_class = resource_name.camelize.constantize
      params do
        optional :includes, desc: 'a json string of what to include, check \'http://apidock.com/rails/ActiveModel/Serializers/JSON/as_json\''
      end
      resources plural_resource_name do
        desc "Find #{resource_name} by ID"
        get ':id' do
          includes = params[:includes].blank?? {} : ActiveSupport::JSON.decode(params[:includes]).symbolize_keys
          entity_class.find(params[:id]).as_json includes
        end
      end
    end

    # required is an array of symbols of attributes
    # default_attrs is a map of all the attributes that should get the default value
    # action is a string that further defines this rest action, for eg.
    #   if action is 'register'
    #     the api built will be 'resource/register'
    def create(resource_sym, required=[], action = '', action_description='', &block)
      resource_name = resource_sym.to_s
      plural_resource_name = resource_name.pluralize
      entity_class = resource_name.camelize.constantize
      resources plural_resource_name do
        desc action_description.blank?? "Create #{resource_name}" : action_description
        params do
          requires *required
        end
        action_block = Proc.new{
          attributes = {}
          # for active record
          #   associations = entity_class.nested_attributes_options.keys
          # for mongoid
          associations = entity_class.nested_attributes.keys.map {|x| x.gsub(/_attributes/, '').to_sym}
          params.each do |k,v|
            attributes[k.to_sym] = v if entity_class.fields.include? k.to_s
            attributes["#{k}_attributes"] = v if associations.include? k.to_sym
          end
          if block_given?
            attributes = block.yield attributes, params
          end
          entity = entity_class.new attributes
          if entity.save
            entity
          else
            status(422)
            entity.errors
          end
        }
        if action.blank?
          post(&action_block)
        else
          post(action, &action_block)
        end
      end
    end

    def update(resource_sym, required=[], action = '', action_description='', &block)
      resource_name = resource_sym.to_s
      plural_resource_name = resource_name.pluralize
      entity_class = resource_name.camelize.constantize
      resources plural_resource_name do
        desc action_description.blank?? "Update #{resource_name}" : action_description
        params do
          requires *required
        end
        action_block = Proc.new{
          attributes = {}
          entity = resource_name.camelize.constantize.find params[:id]
          entity_class = entity._type.constantize if entity.respond_to? :_type
          associations = entity_class.nested_attributes.keys.map {|x| x.gsub(/_attributes/, '').to_sym}
          params.reject{|k| [:route_info, :id, :_id].include? k.to_sym}.each do |k,v|
            attributes[k.to_sym] = v if entity_class.fields.include? k.to_s
            attributes["#{k}_attributes"] = v if associations.include? k.to_sym
          end
          if block_given?
            attributes = block.yield attributes, params
          end
          p ">>ATTRIBUTES>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
          p attributes
          p ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"

          if entity.update_attributes(attributes)
            entity
          else
            status(422)
            entity.errors
          end
        }
        if action.blank?
          put(':id', &action_block)
        else
          put("#{action}/:id", &action_block)
        end
      end
    end

    def destroy(resource_sym)
      resource_name = resource_sym.to_s
      plural_resource_name = resource_name.pluralize
      entity_class = resource_name.camelize.constantize
      params do
        requires :id
      end
      resources plural_resource_name do
        desc "Delete #{resource_name}"
        delete ':id' do
          entity_class.find(params[:id]).destroy
        end
      end
    end

    def crud(resource_sym)
      # all `/:id` must be placed last because mongoid cant use `/[0-9]*/`
      count resource_sym
      all resource_sym
      find resource_sym
      update resource_sym
      create resource_sym
      destroy resource_sym
    end

  end
end

######### originals #########

=begin
      desc 'Create an admin'
      params do
        group :admin do
          requires :email
          requires :password
        end
      end
      post do
        admin = Admin.new(
            email: params[:admin][:email],
            password: params[:admin][:password],
            password_confirmation: params[:admin][:password],
            account_state: Admin::ACCOUNT_ACTIVE
        )
        if admin.save
          admin
        else
          status(400)
          admin.errors
        end
      end
=end