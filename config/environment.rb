# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Bingbong::Application.initialize!

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  :address              => "smtp.gmail.com",
  :port                 => 587,
  :domain               => 'grandmenu.com',
  :user_name            => 'admin@grandmenu.com',
  :password             => '2bee4qABZaUz',
  :authentication       => 'plain',
  :enable_starttls_auto => true
}
ActionMailer::Base.default_url_options = {
  :host => "grandmenu.com"
}
