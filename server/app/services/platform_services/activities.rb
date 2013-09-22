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
          ProjectMailer.send_request_for_quote(event, provider).deliver!
        end
      end

      def add_bidder(pid, uid)
        project = project(pid)
        user = user(uid)
        len = project.bidders.length
        project.bidders << user
        if len < project.bidders.length
          message = "<b><a target=\"_blank\" href=\"/#/freelancers.show/#{user.id}\">#{user.first_name} #{user.last_name}</a></b> has placed a bid on project <a target=\"_blank\" href=\"/#/projects.show/#{project.id}\">#{project.title}</a>"
          project.employer.notifications << Notification.new(read: false, message: message)
          ProjectMailer.add_bidder(user, project.employer, project).deliver!
        end
        project.as_json
      end

      def add_offer(pid, uid)
        project = project(pid)
        user = user(uid)
        len = project.offers.length
        project.offers << user
        if len < project.offers.length
          message = "<b>#{project.employer.first_name} #{project.employer.last_name}</b> offered you a project <a target=\"_blank\" href=\"/#/projects.show/#{project.id}\">#{project.title}</a>"
          user.notifications << Notification.new(read: false, message: message)
          ProjectMailer.add_offer(user, project.employer, project).deliver!
        end
        project.as_json
      end

      def accept_bid(pid, uid)
        project = project(pid)
        if project.project_status != Project::ACTIVE
          project.freelancer = bidder(pid, uid)
          project.project_status = Project::ACTIVE
          project.offers.clear
          project.bidders.clear
          project.save!
          message = "<b>#{project.employer.first_name} #{project.employer.last_name}</b> accepted your bid for project <a target=\"_blank\" href=\"/#/projects.show/#{project.id}\">#{project.title}</a>"
          project.freelancer.notifications << Notification.new(read: false, message: message)
          ProjectMailer.accept_bid(project.freelancer, project.employer, project).deliver!
          ProjectMailer.notify_admin_bid_accepted(project.freelancer, project.employer, project).deliver!
        end
        project.as_json
      end

      def accept_offer(pid, uid)
        project = project(pid)
        if project.project_status != Project::ACTIVE
          project.freelancer = offer(pid, uid)
          project.project_status = Project::ACTIVE
          project.offers.clear
          project.bidders.clear
          project.save!
          message = "<b><a target=\"_blank\" href=\"/#/freelancers.show/#{project.freelancer.id}\">#{project.freelancer.first_name} #{project.freelancer.last_name}</a></b> accepted your offer for project <a href=\"/#/projects.show/#{project.id}\">#{project.title}</a>"
          project.employer.notifications << Notification.new(read: false, message: message)
          ProjectMailer.accept_offer(project.freelancer, project.employer, project).deliver!
          ProjectMailer.notify_admin_offer_accepted(project.freelancer, project.employer, project).deliver!
        end
        project.as_json
      end

      def mark_as_complete(pid)
        project = project(pid)
        raise! CANNOT_MARK_PENDING_PROJECT_AS_COMPLETED if project.project_status == Project::PENDING
        project.project_status = Project::COMPLETED
        project.save!
        project.as_json
      end
    end

  end
end