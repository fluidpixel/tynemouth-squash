class Player < ActiveRecord::Base

has_many :bookings, :dependent => :destroy
belongs_to  :membership_type

validates_presence_of :membership_number, :membership_type, :on => :create
validates_presence_of :last_name
validates_uniqueness_of :membership_number

def self.authenticate(last_name, membership_number)
  if !last_name.blank? && !membership_number.blank?
    player = Player.where("lower(last_name) = ? AND lower(membership_number) = ?", last_name.downcase, membership_number.downcase).first
    if player
      return player
    # elsif membership_number == "xxx"
#       player = Player.where("lower(last_name) = ?", last_name.downcase).first
#       if player
#         return player
#       end
    else
      return nil
    end
  else
    nil
  end
end

def self.authenticateFullName(name, membership_number)
  if !name.blank? && !membership_number.blank?
    last_name = name.split(" ")[1]
    first_name = name.split(" ")[0]
    if !last_name.blank?
      player = Player.where("lower(first_name) = ? AND lower(last_name) = ? AND lower(membership_number) = ?", first_name.downcase, last_name.downcase, membership_number.downcase).first
      if player
        return player
      elsif membership_number == "xxx"
        player = Player.where("lower(first_name) = ? AND lower(last_name) = ?", first_name.downcase, last_name.downcase).first
        if player
          return player
        end 
      else
        return nil
      end
    else
      nil  
    end
  else
    nil
  end
end

def future_bookings
  @future_unpaid = bookings.where('paid = false OR start_time >= ?', DateTime.current).order("start_time ASC")
  return @future_unpaid
end

def full_name
  self.first_name + " " + self.last_name
end

def self.find_all_by_name_containing(text)
  self.where("LOWER(first_name || ' ' || last_name) LIKE ?", "%#{text.downcase}%")
end

def isRestricted
  if self.membership_type.membership_type == 'restricted'
    return true
  else
    return false
  end
end

def self.search(search)  
    if search  
      
      where('last_name || first_name ILIKE ?', "%#{search}%")  
    else  
      all  
    end  
end

end
