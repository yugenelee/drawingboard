module PlatformServices
  module DataAccessors
    def event(eid)
      project = Event.where(id: eid)
      raise! EVENT_NOT_FOUND if project.blank?
      project.first
    end

    def member(uid)
      user = Member.where(id: uid)
      raise! MEMBER_NOT_FOUND if user.blank?
      user.first
    end

    def vendor(uid)
      user = Vendor.where(id: uid)
      raise! VENDOR_NOT_FOUND if user.blank?
      user.first
    end

    def service(name)
      service = Service.where(name: name)
      raise! SERVICE_NOT_FOUND if service.blank?
      service.first
    end
  end
end
