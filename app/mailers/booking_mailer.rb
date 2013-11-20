class BookingMailer < ActionMailer::Base
  
  require 'mail'
  address = Mail::Address.new "bookings@tynemouth-squash.herokuapp.com" # ex: "john@example.com"
  address.display_name = "Tynemouth Squash" # ex: "John Doe"
  # Set the From or Reply-To header to the following:
  
  default from: address.format # returns "John Doe <john@example.com>"
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
  
  def cancel_booking_email(booking)
    @booking = booking
    
    @greeting = @booking.player.first_name + " your booking has been cancelled"
    @court = Court.find(@booking.court_id)

  	@message =  @court.court_name + ", " + @booking.start_time.strftime("%l:%M%P on %A %Ith %B")
	  
    if @booking.player.email
      mail(to: @booking.player.email, subject: @greeting, bcc: "squash@fpstudios.com")
    else
      mail(to: "squash@fpstudios.com", subject: @greeting)
    end
  end
  
  def create_booking_email(booking)
    @booking = booking
    
    @greeting = @booking.player.first_name + " you've booked a squash court"
    @court = Court.find(@booking.court_id)

  	@message =  @court.court_name + ", " + @booking.start_time.strftime("%l:%M%P on %A %Ith %B")
	  
    if @booking.player.email
      mail(to: @booking.player.email, subject: @greeting, bcc: "squash@fpstudios.com")
    else
      mail(to: "squash@fpstudios.com", subject: @greeting)
    end
    
  end
end