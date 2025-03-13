class TimeSlot < ActiveRecord::Base
	belongs_to :court
	has_many :bookings
  
  def is_peak(day, court_id)
    dayOfWeek = Date.current + day.days

    if self.time.hour >= 16 && self.time.hour <= 20 && !dayOfWeek.saturday? && !dayOfWeek.sunday?
      return true
    elsif (court_id == 1 || court_id == 2) && self.time.hour < 12 && (dayOfWeek.saturday? || dayOfWeek.sunday?)
      return true
    else
      return false
    end
  end
  
end
