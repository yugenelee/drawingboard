class ProjectMailer < ActionMailer::Base
  default from: "contactus@creativesatwork.me"

  #AdminEmail = 'felixsagitta@gmail.com, fannytham@creativesatwork.me, jaycetham@creativesatwork.me, melvinsng@creativesatwork.me'
  AdminEmail = 'felixsagitta@gmail.com'
  SiteUrl = 'http://felix.creativesatwork.me'
  #SiteUrl = 'http://staging.creativesatwork.me'
  #SiteUrl = 'http://localhost:3333'

  def send_request_for_quote(event, provider)
    @event = event
    @provider = provider
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo.png'))
    mail to: @provider.vendor.email, subject: 'Someone requested for a quote on your listing'
  end
end


