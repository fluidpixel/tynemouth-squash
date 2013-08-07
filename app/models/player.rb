class Player < ActiveRecord::Base

has_many :bookings

validates_presence_of :membershipNumber, :on => :create
validates_presence_of :lastName
validates_uniqueness_of :membershipNumber

def self.authenticate(lastName, membershipNumber)
  player = Player.where('lower(lastName) = ?', lastName.downcase).first
  if player && player.membershipNumber == membershipNumber.to_i
    player
  else
    nil
  end
end

end
