module PaymentServices
  module DataAccessors

    def provider(pid)
      provider = Provider.where(id: pid)
      raise! PROVIDER_NOT_FOUND if provider.blank?
      provider.first
    end

    def priceplan(pid)
      priceplan = Priceplan.where(id: pid)
      raise! PRICEPLAN_NOT_FOUND if priceplan.blank?
      priceplan.first
    end

    def discount_from_code(code)
      discount = Discount.where(code: code)
      raise! DISCOUNT_NOT_FOUND if discount.blank?
      discount.first
    end

    def payment_from_token(pp_token)
      payment = Payment.where(pp_token: pp_token)
      raise! PAYMENT_NOT_FOUND if payment.blank?
      payment.first
    end

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
