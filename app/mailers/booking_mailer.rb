class BookingMailer < ActionMailer::Base
  default from: "bookings@tynemouth-squash.herokuapp.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailer.daily_email.subject
  #
  def daily_email
    @greeting = "Today's Bookings"
	@bookings = Booking.order("start_time asc").by_day(0)
	
    mail to: "squash@fpstudios.com"
  end
end
