class TimeSlot < ActiveRecord::Base
	belongs_to :court
	has_many :bookings
  
  def is_peak
    if self.time.hour >= 16 && self.time.hour <= 20
      return true
    else
      return false
    end
  end
  
end
