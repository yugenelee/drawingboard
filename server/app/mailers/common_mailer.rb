class CommonMailer < ActionMailer::Base
  default from: "contactus@creativesatwork.me"

  SiteUrl = 'http://staging.creativesatwork.me'
  #SiteUrl = 'http://localhost:3333'
  #Recipients = 'felixsagitta@gmail.com, contactus@creativesatwork.me'

  def contact_us(name_value_hash)
    @name_value_hash = name_value_hash
    mail to: 'tioh.wei.lun99@nus.edu.sg, contactus@creativesatwork.me', subject: 'Contact Us Enquiry'
  end
end
