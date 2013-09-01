class Booking < ActiveRecord::Base

	belongs_to :player
	belongs_to :court
	belongs_to :timeSlot
	
	validates_presence_of :player, :message => 'No player found'
	validates_uniqueness_of :start_time, :scope => :time_slot_id, :message => 'The court has already been booked at that time'
	
	def self.by_day(day)
		return scoped unless day.present?
		bookings = Booking.where('start_time BETWEEN ? AND ?', (DateTime.current + day.days).beginning_of_day, (DateTime.current + day.days).end_of_day).all
	end

	def self.by_court(court)
		return scoped unless court.present?
	  where(:court_id => court)
	end	

	def self.by_time_slot(time_slot)
		return scoped unless time_slot.present?
		where(:time_slot_id => time_slot.id)
	end
	
	def last_name
		player.try(:last_name)
	end
	
	def last_name=(last_name)
		player = Player.where('lower(last_name) = ?', last_name.downcase).first if last_name.present?
		
		if player
			self.player_id = player.id
		end
	end
  
	def vs_player_name
		player.try(:vs_player_name)
	end
	
	def vs_player_name=(vs_player_name)
		player = Player.where('lower(last_name) = ?', vs_player_name.downcase).first if vs_player_name.present?
		
		if player
			self.vs_player_id = player.id
		end
	end
end
