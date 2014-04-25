class BookingsController < ApplicationController

def new
  @error = params[:error] if(params[:error])
	@court = Court.find(params[:court]) if(params[:court])
	@court_name = @court.court_name
	@timeSlot = TimeSlot.find(params[:timeSlot]) if(params[:timeSlot])
  if(params[:hour])
  	@time = DateTime.parse(params[:hour] + ':' + params[:min]) if(params[:hour])
  end
  
  
  @booking = Booking.new	
	@booking.start_time = @time + (params[:days]).to_i.days if(params[:days])
	@booking.time_slot_id = @timeSlot.id
	@booking.court_time = 40
	@booking.court_id = @court.id
	
	@days = params[:days] if(params[:days])
	@booking.player_id = :last_name if(:last_name)
  @booking.vs_player_id = :vs_player_name if (:vs_player_name)
  
end

def create
  
  if !is_admin
    player = Player.authenticateFullName(params[:booking][:last_name], params[:booking][:membership_number])
  else
    player = Player.authenticateFullName(params[:booking][:last_name], "xxx")
  end
  #if params[:booking][:guest_booking]
   # flash.alert = "Guest!"
    #if player
      
    #else
      #create new guest player
      
      #end
    
  #end
  #flash.alert = "booking slots: " + params[:booking][:booking_number]
  
  if player
    #varibles if we fail to save
    @days = params[:booking][:days]
  	@time = params[:booking][:start_time].to_datetime
  	@time_slot_id = params[:booking][:time_slot_id]
    
    @end = params[:booking][:booking_number].to_i
    
    
    for i in 0..@end-1
      @booking = Booking.new(booking_params)
      @booking.time_slot_id = @booking.time_slot_id + i
      
    	if @booking.save
        @saved = true
        BookingMailer.create_booking_email(@booking).deliver
      else
        @saved = false
        flash.alert = 'false'
      end
    end
    
    if @saved == true
    Pusher['test_channel'].trigger('greet', {
      :greeting => "New booking created!"
    })
      if @days
    		redirect_to bookings_path(:day => @days)
    	else
    		redirect_to players_path
    	end
    else
      render 'new'
    end
    
  else
    #render :nothing => true
     #@time = DateTime.parse('13' + ':' + '05')
     #flash.now.alert = "Invalid Surname or Membership Number"
     @error = "Invalid Name: (" + params[:booking][:last_name] + ") or membership number (#{params[:booking][:membership_number]})"
     
    redirect_to new_booking_path(:days => params[:booking][:days], :court => params[:booking][:court_id], :hour => params[:booking][:start_time].to_time.strftime('%H'), :min => params[:booking][:start_time].to_time.strftime('%M'), :timeSlot => params[:booking][:time_slot_id], :error => @error)
  end
  
end

def show
  @booking = Booking.find(params[:id])
  @court = Court.find(@booking.court_id)
  if (((Time.current + 2.days) <= @booking.start_time))
    @cancellable = true
    @timeLeft = (((Time.current + 2.days) - @booking.start_time)).to_i * -1
  end
  if (!@booking.player_id.blank?)
	  @player = Player.find(@booking.player_id)
  end
  if (!@booking.vs_player_id.blank?)
    @vs_player = Player.find(@booking.vs_player_id)
  end
  
end

def edit
	@booking = Booking.find(params[:id])
  
  if (@booking.player_id == session[:player_id] || is_admin)
    @allowEdit = true
  else
    @allowEdit = false
  end
  
  if (!@booking.player_id.blank?)
	  @player = Player.find(@booking.player_id)
  end
  
  if (!@booking.vs_player_id.blank?)
    @vs_player = Player.find(@booking.vs_player_id)
  end
  
	@courts = Court.all
	@players = Player.all
end

def destroy
  @booking = Booking.find(params[:id])
  
  @days = (@booking.start_time.to_date - DateTime.current.to_date).to_i
  
  if @booking && params[:booking]
    player = Player.authenticate(@booking.player.last_name, params[:booking][:membership_number])
  end
  
  if player || is_admin
    BookingMailer.cancel_booking_email(@booking).deliver
    @booking.destroy
    
    Pusher['test_channel'].trigger('greet', {
      :greeting => "Booking Removed!"
    })
    
    flash.alert = "Cancelled Booking"
    if @days
      if @days < 2
        BookingMailer.cancelled_court_late(@booking, current_player).deliver
      end
  		redirect_to bookings_path(:day => @days)
  	else
  		redirect_to bookings_path
  	end
  else
    respond_with @booking
    flash.alert = "Valid Membership number required for cancelling booking" + params[:booking][:membership_number]
  end
  	
end

def update
  @booking = Booking.find(params[:id])
  
  if @booking.update(params[:booking].permit(:court_id, :player_id, :last_name, :start_time, :court_time, :vs_player_name))
    #booking changed, send email?
    redirect_to @booking
  else
    render 'edit'
  end
end

def index
	if (params[:day])
		@day = params[:day].to_i
	else
		@day = 0
	end
	@bookingDay = (DateTime.current + @day.days).strftime("%A %d %B")
	
  @vs_players = Player.all
  
	@daysBookings = Booking.where(Booking.arel_table[:time_slot_id].not_eq(nil)).by_day(@day)
	
  @courts = Court.order("id DESC")
  saturday = [6] #[saturday]
  sunday = [0] #[sunday]
  
  if is_bank_holiday(DateTime.current + @day.days)
		@court1Slots = TimeSlot.where(:court_id => 1).where(:bank_holiday => true).order("time ASC")
		@court2Slots = TimeSlot.where(:court_id => 2).where(:bank_holiday => true).order("time ASC")
		@court3Slots = TimeSlot.where(:court_id => 3).where(:bank_holiday => true).order("time ASC")
		@court4Slots = TimeSlot.where(:court_id => 4).where(:bank_holiday => true).order("time ASC")
		@court5Slots = TimeSlot.where(:court_id => 5).where(:bank_holiday => true).order("time ASC")
    @slots = @court1Slots.count
  elsif (saturday.include?((DateTime.current + @day.days).wday))
		@court1Slots = TimeSlot.where(:court_id => 1).order("time ASC")
		@court2Slots = TimeSlot.where(:court_id => 2).order("time ASC")
		@court3Slots = TimeSlot.where(:court_id => 3).order("time ASC")
		@court4Slots = TimeSlot.where(:court_id => 4).order("time ASC")
		@court5Slots = TimeSlot.where(:court_id => 5).order("time ASC")
    @slots = @court1Slots.count
  elsif (sunday.include?((DateTime.current + @day.days).wday))
		@court1Slots = TimeSlot.where(:court_id => 1).where(:sunday => true).order("time ASC")
		@court2Slots = TimeSlot.where(:court_id => 2).where(:sunday => true).order("time ASC")
		@court3Slots = TimeSlot.where(:court_id => 3).where(:sunday => true).order("time ASC")
		@court4Slots = TimeSlot.where(:court_id => 4).where(:sunday => true).order("time ASC")
		@court5Slots = TimeSlot.where(:court_id => 5).where(:sunday => true).order("time ASC")
    @slots = @court1Slots.count
	else
		@court1Slots = TimeSlot.where(:court_id => 1).where(:weekday => true).order("time ASC")
		@court2Slots = TimeSlot.where(:court_id => 2).where(:weekday => true).order("time ASC")
		@court3Slots = TimeSlot.where(:court_id => 3).where(:weekday => true).order("time ASC")
		@court4Slots = TimeSlot.where(:court_id => 4).where(:weekday => true).order("time ASC")
		@court5Slots = TimeSlot.where(:court_id => 5).where(:weekday => true).order("time ASC")
    @slots = @court1Slots.count
	end
	
	if (@day == 21)
		#@isBookingTime = (Time.current.strftime("%H") >= @court1Slots.first.time.strftime("%H"))
    @isBookingTime = (Time.current.strftime("%H") >= "12")
	else
		@isBookingTime = true;
	end
	
end

def toggle_paid  
	@booking = Booking.find(params[:id])  
	@booking.toggle!(:paid)  
	
  Pusher['test_channel'].trigger('greet', {
    :greeting => "Toggle Paid!"
  })
  
  redirect_to :back
  #redirect_to @booking
  # respond_to do |f|
  #       f.js { render :layout => false, :content_type => "text/javascript; charset=UTF-8" }
  #     end
  #   #render :nothing => true  
end 

private
  def booking_params
    params.require(:booking).permit(:court_id, :player_id, :start_time, :court_time, :time_slot_id, :paid, :last_name, :vs_player_id, :vs_player_name, :guest_booking)
  end
  respond_to :html, :js
end
