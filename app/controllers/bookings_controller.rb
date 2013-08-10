class BookingsController < ApplicationController

def new
	@courts = Court.all
	@players = Player.all
	
	
	@court = Court.find(params[:court])
	@timeSlot = TimeSlot.find(params[:timeSlot])
	
	@time = DateTime.parse(params[:hour] + ':' + params[:min])
	@time = @time + (params[:days]).to_i.days
	
	@days = params[:days]
    @booking = Booking.new
end

def create
	@booking = Booking.new(booking_params)
	@days = params[:booking][:days]
	
	if @booking.save
		redirect_to bookings_path(:day => @days)
	else
		render 'new'
	end
end

def show
  @booking = Booking.find(params[:id])
  @court = Court.find(@booking.court_id)
  if (!@booking.player_id.blank?)
	  @player = Player.find(@booking.player_id)
  end
end

def edit
	@booking = Booking.find(params[:id])
	@courts = Court.all
	@players = Player.all
end

def destroy
  @booking = Booking.find(params[:id])
  @booking.destroy
 
  redirect_to bookings_path
end

def update
  @booking = Booking.find(params[:id])

  if @booking.update(params[:booking].permit(:court_id, :player_id, :start_time, :court_time))
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
	
	@court1Bookings = Booking.by_court(1).by_day(@day)
	@court2Bookings = Booking.by_court(2).by_day(@day)
	@court3Bookings = Booking.by_court(3).by_day(@day)
	@court4Bookings = Booking.by_court(4).by_day(@day)
	@court5Bookings = Booking.by_court(5).by_day(@day)
	
	sunday = 0
	saturday = 6
	weekend = [saturday, sunday]

	if (weekend.include?((DateTime.now + @day.days).wday))
		@court1Slots = TimeSlot.where(:court_id => 1)
		@court2Slots = TimeSlot.where(:court_id => 2)
		@court3Slots = TimeSlot.where(:court_id => 3)
		@court4Slots = TimeSlot.where(:court_id => 4)
		@court5Slots = TimeSlot.where(:court_id => 5)
	else
		@court1Slots = TimeSlot.where(:court_id => 1).where(:weekday => true)
		@court2Slots = TimeSlot.where(:court_id => 2).where(:weekday => true)
		@court3Slots = TimeSlot.where(:court_id => 3).where(:weekday => true)
		@court4Slots = TimeSlot.where(:court_id => 4).where(:weekday => true)
		@court5Slots = TimeSlot.where(:court_id => 5).where(:weekday => true)
	end
	
	@bookingDay = (DateTime.now + @day.days).strftime("%A %d %B")
end


def toggle_paid  
	@booking = Booking.find(params[:id])  
	@booking.toggle!(:paid)  
	
	respond_to do |f|
      f.js
    end
	#render :nothing => true  
end 
	
private
  def booking_params
    params.require(:booking).permit(:court_id, :player_id, :start_time, :court_time, :time_slot_id, :paid)
  end
  respond_to :html, :js
end
