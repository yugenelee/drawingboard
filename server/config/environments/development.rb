DrawingBoard::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = true

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log


  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # change to true to allow email to be sent during development
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default :charset => "utf-8"

  config.action_mailer.delivery_method = :sendmail
  config.action_mailer.sendmail_settings = {
      :location => `which sendmail`.strip!,
      #:arguments => '-i -t -f contactus@drawingboard.com'
  }

=begin
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = {
      address: 'smtp.zoho.com',
      port: '465',
      user_name: 'contactus@creativesatwork.me',
      password: 'Pa$$w0rd',
      authentication: :login,
      ssl: true,
      tls: true,
      enable_starttls_auto: true
  }
=end

end
