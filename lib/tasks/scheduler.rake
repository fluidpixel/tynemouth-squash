desc "This task is called by the Heroku scheduler add-on"
task :send_email => :environment do
  puts "Sending email..."
  BookingMailer.daily_email.deliver_now
  puts "done."
end