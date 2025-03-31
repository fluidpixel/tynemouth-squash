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

  def is_peak_cancellable(days, court_id)
    dayOfWeek = Date.current + days

    if self.time.hour > 17 && !dayOfWeek.saturday? && !dayOfWeek.sunday?
      return false
    elsif (court_id == 1 || court_id == 2) && self.time.hour < 12 && (dayOfWeek.saturday? || dayOfWeek.sunday?)
      return false
    else
      return true
    end
  end
  
end
