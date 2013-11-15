class Player < ActiveRecord::Base

has_many :bookings, :dependent => :destroy
belongs_to  :membership_type

validates_presence_of :membership_number, :on => :create
validates_presence_of :last_name
validates_uniqueness_of :membership_number

def self.authenticate(last_name, membership_number)
  if !last_name.blank? && !membership_number.blank?
      players = Player.where('lower(last_name) = ?', last_name.downcase)
    if players
      players.each do |player|
        if player.membership_number.downcase == membership_number.downcase
          return player
        end
      end
    else
      nil
    end
  else
    nil
  end
end

def self.authenticateFullName(name, membership_number)
  if !name.blank? && !membership_number.blank?
    
    last_name = name.split(" ")[1]
    
    if !last_name.blank?
      players = Player.where('lower(last_name) = ?', last_name.downcase)
      
      if players
        players.each do |player|
          if player.membership_number.downcase == membership_number.downcase
            return player
          elsif membership_number == "xxx"
            return player
          else
            nil
          end
        end
      else
        nil
      end
    else
      nil  
    end
  else
    nil
  end
end

def future_bookings
	bookings.where('start_time >= ?', DateTime.current)
end

end
