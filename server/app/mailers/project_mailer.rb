class ProjectMailer < ActionMailer::Base
  default from: "contactus@creativesatwork.me"

  AdminEmail = 'felixsagitta@gmail.com, fannytham@creativesatwork.me, jaycetham@creativesatwork.me, melvinsng@creativesatwork.me'
  #AdminEmail = 'felixsagitta@gmail.com, contactus@creativesatwork.me'
  SiteUrl = 'http://staging.creativesatwork.me'
  #SiteUrl = 'http://localhost:3333'

  def add_bidder(freelancer, employer, project)
    @freelancer = freelancer
    @employer = employer
    @project = project
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    mail to: employer.email, subject: 'Someone placed a bid on your project'
  end

  def add_offer(freelancer, employer, project)
    @freelancer = freelancer
    @employer = employer
    @project = project
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    mail to: freelancer.email, subject: 'Someone offered you a project'
  end

  def accept_bid(freelancer, employer, project)
    @freelancer = freelancer
    @employer = employer
    @project = project
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    mail to: freelancer.email, subject: "#{employer.first_name} #{employer.last_name} accepted your bid"
  end

  def accept_offer(freelancer, employer, project)
    @freelancer = freelancer
    @employer = employer
    @project = project
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo-w450.png'))
    mail to: employer.email, subject: "#{freelancer.first_name} #{freelancer.last_name} accepted your offer"
  end

  def notify_admin_bid_accepted(freelancer, employer, project)
    @freelancer = freelancer
    @employer = employer
    @project = project
    @siteUrl = SiteUrl
    mail to: AdminEmail, subject: "#{employer.first_name} #{employer.last_name} accepted #{freelancer.first_name} #{freelancer.last_name} bid"
  end

  def notify_admin_offer_accepted(freelancer, employer, project)
    @freelancer = freelancer
    @employer = employer
    @project = project
    @siteUrl = SiteUrl
    mail to: AdminEmail, subject: "#{freelancer.first_name} #{freelancer.last_name} accepted #{employer.first_name} #{employer.last_name} offer"
  end
end


