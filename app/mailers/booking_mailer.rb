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
    @date = Date.current.to_date.strftime("%l:%M%P on %A %dth %B")
    
    @bookingDetails = @court.court_name + ", " + @booking.time_slot.time.strftime("%l:%M%P ") + @booking.start_time.strftime("on %A %dth %B")
    
    @current_member = current_member
     
    mail(to: "courtbookings@tynemouthsquash.com", subject: @greeting)
  end
  
  def cancel_booking_email(booking)
    @booking = booking
    @court = Court.find(@booking.court_id)

    if @booking.player.email?
      @greeting = @booking.player.first_name + " your booking has been cancelled"
      @message =  @court.court_name + ", " + @booking.time_slot.time.strftime("%l:%M%P ") + @booking.start_time.strftime("on %A %dth %B")
      mail(to: @booking.player.email, subject: @greeting) do |format|
        format.text
      end.deliver
    end
    
    if @booking.vs_player_id?
      if @booking.vs_player.email?
        @greeting = "Squash booking against " + @booking.player.first_name + " has been cancelled"
        @message =  @court.court_name + ", " + @booking.time_slot.time.strftime("%l:%M%P ") + @booking.start_time.strftime("on %A %dth %B")
        mail(to: @booking.vs_player.email, subject: @greeting) do |format|
          format.text
        end.deliver
      end
    end
  end
  
  def create_booking_email(booking)
    @booking = booking
    @court = Court.find(@booking.court_id)
    
    if @booking.player.email?
      @greeting = @booking.player.first_name + " you've booked a squash court"
      @message =  @court.court_name + ", " + @booking.time_slot.time.strftime("%l:%M%P ") + @booking.start_time.strftime("on %A %dth %B")
      mail(to: @booking.player.email, subject: @greeting) do |format|
        format.text
      end
    end
    
    if @booking.vs_player_id?
      if @booking.vs_player.email?
        @message =  @court.court_name + ", " + @booking.time_slot.time.strftime("%l:%M%P ") + @booking.start_time.strftime("on %A %dth %B")
        @greeting = "You've been booked to play squash against " + @booking.player.first_name
        mail(to: @booking.vs_player.email, subject: @greeting) do |format|
          format.text
        end
      end
    end
  end
end