module PlatformServices
  class Activities < Base

    self.extend PlatformServices::DataAccessors

    class << self

      def save_event_form(form_object)
        if form_object[:id]
          event = event(form_object[:id])
        else
          event = Event.new
          event.member_id = form_object[:member_id]
        end
        event.alternate_contact_number = form_object[:alternate_contact_number]
        event.contact_email = form_object[:contact_email]
        event.date = form_object[:date]
        event.ends_at = form_object[:ends_at]
        event.location = form_object[:location]
        event.name = form_object[:name]
        event.number_of_guests = form_object[:number_of_guests]
        event.preferred_contact_method = form_object[:preferred_contact_method]
        event.preferred_contact_number = form_object[:preferred_contact_number]
        event.starts_at = form_object[:starts_at]
        event.vision = form_object[:vision]
        event.save!
      end

      def submit_event_form_and_register(form_object)
        response = AccountServices::UserService.register('Member', form_object[:email], 'local', form_object[:email], form_object[:password], {first_name: form_object[:first_name], last_name: form_object[:last_name]})
        event = Event.new
        event.member_id = response[:user][:id]
        event.alternate_contact_number = form_object[:alternate_contact_number]
        event.contact_email = form_object[:email]
        event.date = form_object[:date]
        event.ends_at = form_object[:ends_at]
        event.location = form_object[:location]
        event.name = form_object[:name]
        event.number_of_guests = form_object[:number_of_guests]
        event.preferred_contact_method = form_object[:preferred_contact_method]
        event.preferred_contact_number = form_object[:preferred_contact_number]
        event.starts_at = form_object[:starts_at]
        event.vision = form_object[:vision]
        event.save!
        rfq = {}
        form_object.cart.each do |service_name, providers|
          providers.each do |provider_id, provider_name|
            rfq[provider_id] ||= {}
            rfq[provider_id][service_name] = 1
          end
        end
        rfq.each do |provider_id, value|
          provider = Provider.find provider_id
          ProjectMailer.delay.send_request_for_quote(event.id, provider.id)
        end
      end

      def submit_event_form(form_object)
        if form_object[:id]
          event = event(form_object[:id])
        else
          event = Event.new
          event.member_id = form_object[:member_id]
        end
        event.alternate_contact_number = form_object[:alternate_contact_number]
        event.contact_email = form_object[:contact_email]
        event.date = form_object[:date]
        event.ends_at = form_object[:ends_at]
        event.location = form_object[:location]
        event.name = form_object[:name]
        event.number_of_guests = form_object[:number_of_guests]
        event.preferred_contact_method = form_object[:preferred_contact_method]
        event.preferred_contact_number = form_object[:preferred_contact_number]
        event.starts_at = form_object[:starts_at]
        event.vision = form_object[:vision]
        event.save!
        rfq = {}
        form_object.cart.each do |service_name, providers|
          providers.each do |provider_id, provider_name|
            rfq[provider_id] ||= {}
            rfq[provider_id][service_name] = 1
          end
        end
        rfq.each do |provider_id, value|
          provider = Provider.find provider_id
          ProjectMailer.delay.send_request_for_quote(event.id, provider.id)
        end
      end
    end

  end
end