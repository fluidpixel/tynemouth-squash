class TimeSlot < ActiveRecord::Base
	belongs_to :court
	has_many :bookings
  
  def is_peak(day)
    
    if self.time.hour >= 16 && self.time.hour <= 20 && !(Date.current + day.days).saturday? && !(Date.current + day.days).sunday?
      return true
    else
      return false
    end
  end
  
end
