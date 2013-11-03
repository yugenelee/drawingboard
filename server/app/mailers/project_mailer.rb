class ProjectMailer < ActionMailer::Base
  default from: "admin@drawingboard.com"

  AdminEmail = 'felixsagitta@gmail.com'
  #SiteUrl = 'http://162.243.15.77'
  SiteUrl = 'http://localhost:3333'

  def send_request_for_quote(event_id, provider_id)
    @event_id = Event.find event_id
    @provider = Provider.find provider_id
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo.png'))
    mail to: @provider.vendor.email, subject: 'Someone requested for a quote on your listing'
  end
end


