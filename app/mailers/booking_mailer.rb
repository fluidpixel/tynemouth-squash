class BookingMailer < ActionMailer::Base
  
  require 'mail'
  address = Mail::Address.new "bookings@tynemouth-squash.herokuapp.com" # ex: "john@example.com"
  address.display_name = "Tynemouth Squash Club" # ex: "John Doe"
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
	
    if !@bookings.empty?
      mail to: "courtbookings@tynemouthsquash.com"
    end
  end
  
  def cancelled_court_late(booking, current_member)
    @booking = booking
    @court = Court.find(@booking.court_id)
    @greeting = @court.court_name + " has been cancelled late"
    
    @message = @court.court_name + " has been cancelled with less than 48 hours notice. You need to check if it's not rebooked. If not then " + @booking.player.first_name + " " + @booking.player.last_name + " needs to be fined."
    @date = DateTime.current.to_date.strftime("%l:%M%P on %A %dth %B")
    
    @bookingDetails = @court.court_name + ", " + @booking.start_time.strftime("%l:%M%P on %A %dth %B")
    
    @current_member = current_member
     
    mail(to: "courtbookings@tynemouthsquash.com", subject: @greeting)
  end
  
  def cancel_booking_email(booking)
    @booking = booking
    
    @greeting = @booking.player.first_name + " your booking has been cancelled"
    @court = Court.find(@booking.court_id)

  	@message =  @court.court_name + ", " + @booking.start_time.strftime("%l:%M%P on %A %dth %B")
	  
    if @booking.player.email
      #mail(to: @booking.player.email, subject: @greeting, bcc: "squash@fpstudios.com")
    else
      #mail(to: "squash@fpstudios.com", subject: @greeting)
    end
  end
  
  def create_booking_email(booking)
    @booking = booking
    
    @greeting = @booking.player.first_name + " you've booked a squash court"
    @court = Court.find(@booking.court_id)

  	@message =  @court.court_name + ", " + @booking.start_time.strftime("%l:%M%P on %A %dth %B")
	  
    if @booking.player.email
      mail(to: @booking.player.email, subject: @greeting)
    else
      #mail(to: "squash@fpstudios.com", subject: @greeting)
    end
    
  end
end