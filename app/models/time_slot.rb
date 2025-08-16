class TimeSlot < ActiveRecord::Base
	belongs_to :court
	has_many :bookings
  
  def is_peak(day, court_id)
    dayOfWeek = Date.current + day.days
    # weekday 16:00-19:10
    if self.time.hour >= 16 && self.time.hour < 20 && !dayOfWeek.saturday? && !dayOfWeek.sunday?
      if self.time.hour == 19 && self.time.min > 10
        return false
      end
      return true
    # elsif (court_id == 1 || court_id == 2) && self.time.hour < 12 && (dayOfWeek.saturday? || dayOfWeek.sunday?)
    #   return true
    # Sunday 17:00-19:50
    elsif dayOfWeek.sunday? && self.time.hour >= 17 && self.time.hour <= 19
      return true
    else
      return false
    end
  end

  def is_peak_cancellable(days, court_id)
    dayOfWeek = Date.current + days

    if self.time.hour > 17 && !dayOfWeek.saturday? && !dayOfWeek.sunday?
      return false
    # elsif (court_id == 1 || court_id == 2) && self.time.hour < 12 && (dayOfWeek.saturday? || dayOfWeek.sunday?)
    #   return false
    else
      return true
    end
  end
  
end
