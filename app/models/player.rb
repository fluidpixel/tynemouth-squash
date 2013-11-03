class Player < ActiveRecord::Base

has_many :bookings
belongs_to  :membership_type

validates_presence_of :membership_number, :on => :create
validates_presence_of :last_name
validates_uniqueness_of :membership_number

def self.authenticate(last_name, membership_number)
  if !last_name.blank? && !membership_number.blank?
      player = Player.where('lower(last_name) = ?', last_name.downcase).first
    if player && player.membership_number == membership_number
      player
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
      player = Player.where('lower(last_name) = ?', last_name.downcase).first
    if player && player.membership_number == membership_number
      player
    else
      nil
    end
  elsif !name.blank?
    last_name = name.split(" ")[1]
    player = Player.where('lower(last_name) = ?', last_name.downcase).first
    player
  else
    nil
  end
end

def future_bookings
	bookings.where('start_time >= ?', DateTime.current)
end

end
