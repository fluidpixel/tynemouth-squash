class Booking < ActiveRecord::Base

	belongs_to :player
	belongs_to :court
	belongs_to :vs_player, :class_name => 'Player'
  
	validates_presence_of :player, :message => 'No player found'
	validates_uniqueness_of :start_time, :scope => :time_slot_id, :message => 'The court has already been booked at that time'
	
  # before_create :check_date_uniqueness, :mess
  
  attr_accessor :booking_number
  
	def self.by_day(day)
		return scoped unless day.present?
		bookings = Booking.where('start_time BETWEEN ? AND ?', (Date.current + day.days).beginning_of_day, (Date.current + day.days).end_of_day).load
	end

	def self.by_court(court)
		return scoped unless court.present?
	  where(:court_id => court)
	end	

	def self.by_time_slot(time_slot)
		return scoped unless time_slot.present?
		where(:time_slot_id => time_slot.id)
	end
	
	def full_name
		player.try(:first_name)
	end
	
	def full_name=(full_name)
    if full_name.present?
      @nameArray = full_name.downcase.split
      if @nameArray.count > 1
        full_name = full_name.downcase
    		player = Player.where('lower(first_name) = ? AND lower(last_name) = ?', full_name.split(" ")[0], full_name.split(" ")[1]).first
    		if player
    			self.player_id = player.id
    		end
      else
    		player = Player.where('lower(first_name) = ? AND lower(last_name) = ?', "guest", full_name.split(" ")[0]).first
    		if player
    			self.player_id = player.id
    		end
      end
    end
	end
  
  def time_slot
    time_slot = TimeSlot.find(self.time_slot_id)
  end
  
  def incurs_fine
    if (self.start_time.to_date - Date.current).to_i < 0 && !self.paid && self.start_time.hour >= 16 && self.start_time.hour <= 20 && !self.start_time.saturday? && !self.start_time.sunday?
      return true
	elsif (self.start_time.to_date - Date.current).to_i < 0 && !self.paid && self.start_time.hour < 12 && (self.start_time.saturday? || self.start_time.sunday?)
	  return true
    else
      return false
    end
  end
  
  def should_incur_fine
    if self.start_time.hour >= 16 && self.start_time.hour <= 20 && !self.start_time.saturday? && !self.start_time.sunday?
      return true
	elsif self.start_time.hour < 12 && (self.start_time.saturday? || self.start_time.sunday?)
	  return true
    else
      return false
    end
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
  
  def day
     (self.start_time.to_date - Date.current).to_i
  end
  
end
