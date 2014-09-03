class Booking < ActiveRecord::Base

	belongs_to :player
	belongs_to :court
	belongs_to :vs_player, :class_name => 'Player'
  
	validates_presence_of :player, :message => 'No player found'
	validates_uniqueness_of :start_time, :scope => :time_slot_id, :message => 'The court has already been booked at that time'
	
  attr_accessor :booking_number
  
	def self.by_day(day)
		return scoped unless day.present?
		bookings = Booking.where('start_time BETWEEN ? AND ?', (DateTime.current + day.days).beginning_of_day, (DateTime.current + day.days).end_of_day).load
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
		player.try(:first_name)
	end
	
	def last_name=(last_name)
    if last_name.present?
      @nameArray = last_name.downcase.split
      if @nameArray.count > 1
        last_name = last_name.downcase
    		player = Player.where('lower(first_name) = ? AND lower(last_name) = ?', last_name.split(" ")[0], last_name.split(" ")[1]).first
    		if player
    			self.player_id = player.id
    		end
      else
    		player = Player.where('lower(first_name) = ? AND lower(last_name) = ?', "guest", last_name.split(" ")[0]).first
    		if player
    			self.player_id = player.id
    		end
      end
    end
	end
  
  def time_slot
    time_slot = TimeSlot.find(self.time_slot_id)
  end
  
	def vs_player_name
    #player ? player.vs_player_name : ""
		player.try(:vs_player_name)
	end
	
	def vs_player_name=(vs_player_name)
    vs_player_name = vs_player_name.downcase
    
		player = Player.where('lower(first_name) = ? AND lower(last_name) = ?', vs_player_name.split(" ")[0], vs_player_name.split(" ")[1]).first if vs_player_name.present?
		
		if player
			self.vs_player_id = player.id
    else
      self.vs_player_id = nil
		end
	end
end
