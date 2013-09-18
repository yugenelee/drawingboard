class UserMailer < ActionMailer::Base
  default from: "contactus@drawingboard.com"

  SiteUrl = 'http://162.243.15.77'
  #SiteUrl = 'http://localhost:3333'

  def activate_account(user, token)
    @user = user
    @siteUrl = SiteUrl
    @siteLoginLink = "#{SiteUrl}/#/#{user.user_type.downcase}.login"
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo.png'))
    @confirmation_link = "#{SiteUrl}/#/account.email_confirmation/#{user.id}/#{token}"
    mail to: user.email, subject: 'Account Activation'
  end

  def reset_password(user, token)
    @user = user
    @siteUrl = SiteUrl
    attachments.inline['logo.png'] = File.read(File.join(Rails.root, 'assets/logo.png'))
    @reset_link = "#{SiteUrl}/#/account.reset_password/#{user.id}/#{token}"
    mail to: user.email, subject: 'Account reset password'
  end
end
