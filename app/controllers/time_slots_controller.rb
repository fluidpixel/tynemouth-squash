class TimeSlotsController < ApplicationController
  
def show
  @timeSlot = TimeSlot.find(params[:id])
end

def edit
  @timeSlot = TimeSlot.find(params[:id])
end

def index
  # @timeSlots = TimeSlot.all
  @timeSlots = TimeSlot.where(:covid_slot => false).order(:court_id, :time).all
end

def update
  @timeSlot = TimeSlot.find(params[:id])

  if @timeSlot.update(params[:time_slot].permit(:weekday, :sunday, :bank_holiday))
    redirect_to time_slots_path
  else
    render 'edit'
  end
end

private
  def slot_params
    params.require(:timeSlot).permit(:time, :court_id)
  end
  
end
