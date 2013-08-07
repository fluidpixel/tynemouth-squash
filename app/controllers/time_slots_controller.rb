class TimeSlotsController < ApplicationController
  
def show
end

def index
  @timeSlots = TimeSlot.all
end

private
  def slot_params
    params.require(:timeSlot).permit(:time, :court_id)
  end
  
end
