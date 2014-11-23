# Load the Rails application.
require File.expand_path('../application', __FILE__)
require 'dropbox-api'

# Load the app's custom environment variables here, so that they are loaded before environments/*.rb
app_environment_variables = File.join(Rails.root, 'config', 'app_environment_variables.rb')
load(app_environment_variables) if File.exists?(app_environment_variables)

# Initialize the Rails application.
Squash::Application.initialize!

#sendgrid
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default_content_type = 'text/plain'
ActionMailer::Base.smtp_settings 
  {
  :user_name => ENV['SENDGRID_USERNAME'],
  :password => ENV['SENDGRID_PASSWORD'],
  :domain => 'heroku.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
  }
