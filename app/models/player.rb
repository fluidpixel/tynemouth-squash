class Player < ActiveRecord::Base

has_many :bookings

validates_presence_of :membership_number, :on => :create
validates_presence_of :last_name
validates_uniqueness_of :membership_number

def self.authenticate(last_name, membership_number)
  player = Player.where('lower(last_name) = ?', last_name.downcase).first
  if player && player.membership_number == membership_number.to_i
    player
  else
    nil
  end
end

end
