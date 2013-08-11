class Booking < ActiveRecord::Base

	belongs_to :player
	belongs_to :court
	belongs_to :timeSlot
	
	def self.by_day(day)
		return scoped unless day.present?
		bookings = Booking.where('start_time BETWEEN ? AND ?', (DateTime.now + day.days).beginning_of_day, (DateTime.now + day.days).end_of_day).all
	end

	def self.by_court(court)
		return scoped unless court.present?
	  where(:court_id => court)
	end	

	def self.by_time_slot(time_slot)
		return scoped unless time_slot.present?
		where(:time_slot_id => time_slot.id)
	end
end
