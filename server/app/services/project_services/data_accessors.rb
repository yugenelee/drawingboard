module ProjectServices
  module DataAccessors
    def project(pid)
      project = Project.where(id: pid)
      raise! PROJECT_NOT_FOUND if project.blank?
      project.first
    end

    def user(uid)
      user = Freelancer.where(id: uid)
      raise! USER_NOT_FOUND if user.blank?
      user.first
    end

    def bidder(pid,uid)
      user(uid)
      bidder = project(pid).bidders.where(id: uid)
      raise! BIDDER_DOES_NOT_EXIST if bidder.blank?
      bidder.first
    end

    def offer(pid,uid)
      user(uid)
      offer = project(pid).offers.where(id: uid)
      raise! OFFER_DOES_NOT_EXIST if offer.blank?
      offer.first
    end
  end
end
