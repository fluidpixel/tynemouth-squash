class BookingsController < ApplicationController
  
def new
	@error = params[:error] if(params[:error])
	@court = Court.find(params[:court]) if(params[:court])
	@court_name = @court.court_name
	@timeSlot = TimeSlot.find(params[:timeSlot]) if(params[:timeSlot])
  @forcebooking = params[:force_booking] if(params[:force_booking])
  
	@days = params[:days] ? (params[:days]) : 0
  
  if (params[:hour]) 
    @time = Time.zone.parse(params[:hour] + ':' + params[:min])
  else 
    @time = Time.zone
  end
  
	@time += @days.to_i.days
  
	@booking = Booking.new	
	@booking.start_time = @time
	@booking.time_slot_id = @timeSlot.id
	@booking.court_time = 40
	@booking.court_id = @court.id
	@booking.player_id = :full_name if(:full_name)
	@booking.vs_player_id = :vs_player_name if (:vs_player_name)
  
end

def create
  
  if !is_admin
    player = Player.authenticateFullName(params[:booking][:full_name], params[:booking][:membership_number])
  else
    player = Player.authenticateFullName(params[:booking][:full_name], "xxx")
  end
  
  vs_player = Player.authenticateFullName(params[:booking][:vs_player_name], "xxx")

  if params[:booking][:guest_booking] == "1" #true
    if player
      
    else
      #create new guest player
      @nameArray = params[:booking][:full_name].split
      #@nameArray = @fullname.
      
      @player = Player.new
      if @nameArray.count > 1
        @player.first_name = @nameArray[0]
        @player.last_name = @nameArray[1]
      else
        @player.first_name = "guest"
        @player.last_name = params[:booking][:full_name]
      end
      
      @player.membership_number = "guest_" + (Player.last.id + 1).to_s
      
      @membershipType = MembershipType.where(:membership_type => "guest")
      
      @player.membership_type_id = @membershipType.first.id
      
      if @player.save
        flash.alert = "guest_" + (Player.last.id + 1).to_s
        player = @player
      else
        #flash.alert = "guest_" + (Player.last.id + 1).to_s
        #flash.alert = @mem.first.id
        #flash.alert = @player.first_name + " " + @player.last_name + " " + @player.membership_number + " " + @player.membership_type_id
      end
    end
  end
  
  #flash.alert = "booking slots: " + params[:booking][:booking_number]
  if player || @player
    #varibles if we fail to save
    @day = params[:booking][:days]
    @time = ActiveSupport::TimeWithZone.new(nil, Time.zone, Time.zone.parse(params[:booking][:start_time]))
    
    # @time = Time.zone.parse(params[:booking][:start_time]).to_datetime
  	@time_slot_id = params[:booking][:time_slot_id]

    @end = params[:booking][:booking_number].to_i
    @forcebooking = params[:force_booking] if(params[:force_booking])
    
    #restricted player bookings
    #not sunday between 17-19:50
    #not weekdays between 16-19:10
    if player.isRestricted || (vs_player && vs_player.isRestricted)
      if @time.sunday? && @time.hour >= 17 && @time.hour <= 19
        @error = "Restricted Membership, can't book between 5-8pm on a Sunday."
        redirect_to new_booking_path(
          :days => params[:booking][:days],
          :court => params[:booking][:court_id],
          :hour => @time.strftime('%H'),
          :min => @time.strftime('%M'),
          :timeSlot => params[:booking][:time_slot_id],
          :error => @error) and return
      elsif !@time.saturday? && @time.hour >= 16 && @time.hour < 20
        if @time.hour == 19 && @time.min > 10
          #ignore
        else
          @error = "Restricted Membership, can't book between 4-7:30pm on a weekday."
        redirect_to new_booking_path(
          :days => params[:booking][:days],
          :court => params[:booking][:court_id],
          :hour => @time.strftime('%H'),
          :min => @time.strftime('%M'),
          :timeSlot => params[:booking][:time_slot_id],
          :error => @error) and return
        end
      end
    end
    
    if !player.isValidMember
      if player.isArchived
        @error = 'Your account has been deactived. If this has been a mistake, please contact the club'
      else
        @error = "Sorry, your 3 month Trial membership has expired. Please contact the club"
      end
      redirect_to new_booking_path(:days => params[:booking][:days], :court => params[:booking][:court_id], :hour => @time.strftime('%H'), :min => @time.strftime('%M'), :timeSlot => params[:booking][:time_slot_id], :error => @error) and return
    end
    
    if player.unpaid_bookings.count >= 2 && player.isFineable
      if is_admin
        @error = player.full_name + ' has 2 or more outstanding unpaid courts'
        if @forcebooking == "true"
          #allow booking anyway
        else
          redirect_to new_booking_path(:days => params[:booking][:days], :court => params[:booking][:court_id], :hour => @time.strftime('%H'), :min => @time.strftime('%M'), :timeSlot => params[:booking][:time_slot_id], :full_name => params[:booking][:full_name], :vs_player_name => params[:booking][:vs_player_name], :booking_number => params[:booking][:booking_number], :force_booking => "true", :error => @error) and return
        end
      else
        @error = 'Sorry, you cannot book with 2 or more outstanding unpaid courts'
        redirect_to new_booking_path(:days => params[:booking][:days], :court => params[:booking][:court_id], :hour => @time.strftime('%H'), :min => @time.strftime('%M'), :timeSlot => params[:booking][:time_slot_id], :error => @error) and return
      end
      
    end
    
    for i in 0..@end-1
      @booking = Booking.new(booking_params)
      @booking.time_slot_id = @booking.time_slot_id + i
      
      if timeslot = TimeSlot.find_by(id: @booking.time_slot_id)
      
        puts "booking CourtID: #{timeslot.court_id}"
        puts "params courtID: #{params[:booking][:court_id].to_i}"
      
        if timeslot.court_id == params[:booking][:court_id].to_i
          puts "CORRECT COURT"
        	if @booking.save
            puts "SAVED"
            @saved = true
            BookingMailer.create_booking_email(@booking).deliver_now
            BookingMailer.vs_booking_email(@booking).deliver_now
          else
            @saved = false
            #flash.alert = 'false'
          end
        else
          puts "BREAK"
          break
        end
      else
        puts "ID doesn't exist"
        break
      end
    end
    
    if @saved == true
      Pusher['tynemouthChannel'].trigger('booking', { :greeting => "New booking created!", :reloadDay => @day })
      view_context.send_to_dropbox(@day)
      
      if @day
        #render inline: data
    		redirect_to bookings_path(:day => @day)
    	else
    		redirect_to players_path
    	end
    else
      @error = 'Sorry, this booking could not be saved'
      redirect_to new_booking_path(:days => params[:booking][:days], :court => params[:booking][:court_id], :hour => @time.strftime('%H'), :min => @time.strftime('%M'), :timeSlot => params[:booking][:time_slot_id], :error => @error) and return
    end
    
  else
    #render :nothing => true
     #@time = DateTime.parse('13' + ':' + '05')
     #flash.now.alert = "Invalid Surname or Membership Number"
     @error = "Invalid Name: (" + params[:booking][:full_name] + ") or membership number: (#{params[:booking][:membership_number]})"
     
    redirect_to new_booking_path(:days => params[:booking][:days], :court => params[:booking][:court_id], :hour => params[:booking][:start_time].to_time.strftime('%H'), :min => params[:booking][:start_time].to_time.strftime('%M'), :timeSlot => params[:booking][:time_slot_id], :error => @error)
  end
  
end

def show
  @booking = Booking.find(params[:id])
  
  @days = (@booking.start_time.to_date - Date.current).to_i
  
  @timeSlot = TimeSlot.find(@booking.time_slot_id)

  @court = Court.find(@booking.court_id)
  
  if (Time.current + 2.days) <= @booking.start_time.end_of_day
    @cancellable = true
    @timeLeft = ((Time.current + 2.days) - @booking.start_time.end_of_day).to_i * -1
  # elsif @booking.start_time.hour < 17 && @booking.start_time > Time.current
  #   @timeLeft = (Time.current - @booking.start_time).to_i * -1
  #   @cancellable = true
  # elsif @timeSlot.is_peak_cancellable(@days, @booking.court_id)
  #   @cancellable = true
  #   @timeLeft = (Time.current - @booking.start_time).to_i * -1
  # elsif @booking.start_time.hour < 12 && (@booking.court_id == 1 || @booking.court_id == 2)
  #   @timeLeft = (Time.current - @booking.start_time).to_i * -1
  #   @cancellable = true
  # elsif @booking.start_time.hour < 17 && @booking.start_time > Time.current || @time.sunday? || @time.saturday?
  #   @timeLeft = (Time.current - @booking.start_time).to_i * -1
  #   @cancellable = true
  end

  if (!@booking.player_id.blank?)
	  @player = Player.find_by_id(@booking.player_id)
  end
  if (!@booking.vs_player_id.blank?)
    @vs_player = Player.find_by_id(@booking.vs_player_id)
  end
  
end

def processform
  
  @booking = Booking.find(params[:id])
  
  if params[:commit] == 'Cancel Booking'
    @days = (@booking.start_time.to_date - Date.current).to_i
    cancel_court(params)
  else
    if @booking# && params[:booking]
      player = Player.authenticate(@booking.player.last_name, params[:membership_number])
    end
    
    if is_admin
      redirect_to edit_booking_path(:id => @booking.id)
    elsif player
      redirect_to edit_booking_path(:id => @booking.id, :allow_edit => true)
    elsif @booking.cancelled
      redirect_to edit_booking_path(:id => @booking.id)
    else
      redirect_to booking_path(:id => @booking.id)
      flash.alert = "matching Membership number required for changing booking " + params[:membership_number]
    end
    
  end
end

def edit
	@booking = Booking.find(params[:id])
  @error = params[:error] if(params[:error])
  
  if (@booking.player_id == session[:player_id] || is_admin || params[:allow_edit] || @booking.cancelled)
    @allowEdit = true
  else
    @allowEdit = false
  end
  
  if params[:allow_edit]
    @editPlayer = false
  else
    @editPlayer = true
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
  cancel_court(params)
end

def update
  @booking = Booking.find(params[:id])
  
  
  if !is_admin
    player = Player.authenticateFullName(params[:booking][:full_name], params[:booking][:membership_number])
  else
    player = Player.authenticateFullName(params[:booking][:full_name], "xxx")
  end
  
  if player
    @booking.cancelled = false;
    if @booking.update(params[:booking].permit(:court_id, :player_id, :full_name, :start_time, :court_time, :vs_player_name))
      #booking changed, send email?
      
      @day = (@booking.start_time.to_date - Date.current).to_i
      view_context.send_to_dropbox(@day)
      redirect_to @booking
    else
      render 'edit'
    end
  else
    @error = "Invalid Name: (" + params[:booking][:full_name] + ") or membership number: (#{params[:booking][:membership_number]})"
    redirect_to edit_booking_path(params[:id], :error => @error)
  end
end

def index
	if (params[:day])
		@day = params[:day].to_i
	else
		@day = 0
	end
  
	@bookingDay = (Date.current + @day.days).strftime("%A %d %B")
	@bookingDate = (Date.current + @day.days)

	@daysBookings = Booking.where(Booking.arel_table[:time_slot_id].not_eq(nil)).by_day(@day)
  
  currentDay = Date.current + @day.days

  @courts = Court.order("id DESC")
  saturday = [6] #[saturday]
  sunday = [0] #[sunday]
  
  covid_slot = is_covid_day(currentDay)

  if is_closed_day(currentDay)
    @slots = 0
  elsif is_bank_holiday(currentDay)
		@court1Slots = TimeSlot.where(:court_id => 1).where(:bank_holiday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court2Slots = TimeSlot.where(:court_id => 2).where(:bank_holiday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court3Slots = TimeSlot.where(:court_id => 3).where(:bank_holiday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court4Slots = TimeSlot.where(:court_id => 4).where(:bank_holiday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court5Slots = TimeSlot.where(:court_id => 5).where(:bank_holiday => true).where(:covid_slot => covid_slot).order("time ASC")
    @slots = @court1Slots.count
  elsif (saturday.include?((currentDay).wday))
		@court1Slots = TimeSlot.where(:court_id => 1).where(:covid_slot => covid_slot).order("time ASC")
		@court2Slots = TimeSlot.where(:court_id => 2).where(:covid_slot => covid_slot).order("time ASC")
		@court3Slots = TimeSlot.where(:court_id => 3).where(:covid_slot => covid_slot).order("time ASC")
		@court4Slots = TimeSlot.where(:court_id => 4).where(:covid_slot => covid_slot).order("time ASC")
		@court5Slots = TimeSlot.where(:court_id => 5).where(:covid_slot => covid_slot).order("time ASC")
    @slots = @court1Slots.count
  elsif (sunday.include?((currentDay).wday))
		@court1Slots = TimeSlot.where(:court_id => 1).where(:sunday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court2Slots = TimeSlot.where(:court_id => 2).where(:sunday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court3Slots = TimeSlot.where(:court_id => 3).where(:sunday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court4Slots = TimeSlot.where(:court_id => 4).where(:sunday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court5Slots = TimeSlot.where(:court_id => 5).where(:sunday => true).where(:covid_slot => covid_slot).order("time ASC")
    @slots = @court1Slots.count
	else
		@court1Slots = TimeSlot.where(:court_id => 1).where(:weekday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court2Slots = TimeSlot.where(:court_id => 2).where(:weekday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court3Slots = TimeSlot.where(:court_id => 3).where(:weekday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court4Slots = TimeSlot.where(:court_id => 4).where(:weekday => true).where(:covid_slot => covid_slot).order("time ASC")
		@court5Slots = TimeSlot.where(:court_id => 5).where(:weekday => true).where(:covid_slot => covid_slot).order("time ASC")
    @slots = @court1Slots.count
	end
	
	if (@day == 21 && !is_admin)
    if is_closed_day(Date.current)
      @isBookingTime = false
    elsif is_bank_holiday(Date.current)
      @isBookingTime = (Time.current.strftime("%H") >= TimeSlot.where(:court_id => 1).where(:bank_holiday => true).where(:covid_slot => covid_slot).order("time ASC").first.time.strftime("%H"))
    elsif saturday.include?(Date.current.wday)
      @isBookingTime = (Time.current.strftime("%H") >= TimeSlot.where(:court_id => 1).where(:covid_slot => covid_slot).order("time ASC").first.time.strftime("%H"))      
    elsif sunday.include?(Date.current.wday)
      @isBookingTime = (Time.current.strftime("%H") >= TimeSlot.where(:court_id => 1).where(:covid_slot => covid_slot).where(:sunday => true).order("time ASC").first.time.strftime("%H"))      
    else
      @isBookingTime = (Time.current.strftime("%H") >= TimeSlot.where(:court_id => 1).where(:covid_slot => covid_slot).where(:weekday => true).order("time ASC").first.time.strftime("%H"))
    end
  elsif (@day > 21 && !is_admin)
		@isBookingTime = false
  else
    @isBookingTime = true
	end

end

def toggle_paid  
	@booking = Booking.find(params[:id])  
	@booking.toggle!(:paid)  
	
  Pusher['tynemouthChannel'].trigger('togglePaid', {
    :greeting => "Toggle Paid!"
  })
  
  redirect_back fallback_location: root_path
end 

private

  def cancel_court(params)
    @booking = Booking.find(params[:id])
  
    @days = (@booking.start_time.to_date - Date.current).to_i
  
    if @booking
      player = Player.authenticate(@booking.player.last_name, params[:membership_number])
    end
    
    if player || is_admin
    
      if @booking.cancelled
        
        @booking.destroy
  
        view_context.send_to_dropbox(@days)
      
        Pusher['tynemouthChannel'].trigger('booking', {
          :greeting => "Booking Removed!", :reloadDay => @days
        })
      
        flash.alert = "Removed Cancelled Booking"
        if @days
          redirect_to bookings_path(:day => @days)
        end
      
      elsif @days
        if @days < 2 && @booking.should_incur_fine
        
          @booking.cancelled = true;
          @booking.save
        
          BookingMailer.cancelled_court_late(@booking, current_player).deliver_now
          flash.alert = "Peak Court cancelled too late to remove!"
        else
        
          @booking.destroy
          Thread.new do
            BookingMailer.cancel_booking_email(@booking).deliver_now
            view_context.send_to_dropbox(@days)
            ActiveRecord::Base.connection.close
          end
                
          Pusher['tynemouthChannel'].trigger('booking', {
            :greeting => "Booking Removed!", :reloadDay => @days
          })
    
          flash.alert = "Removed Booking"
        end
      
    		redirect_to bookings_path(:day => @days)
    	else
    		redirect_to bookings_path
    	end
    else
      redirect_to booking_path(:id => @booking.id)
      flash.alert = "Valid Membership number required for cancelling booking"
    end
  end
  
  def booking_params
    params.require(:booking).permit(:court_id, :player_id, :start_time, :court_time, :time_slot_id, :paid, :full_name, :vs_player_id, :vs_player_name, :guest_booking)
  end
  respond_to :html, :js
end
