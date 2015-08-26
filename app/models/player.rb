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
  @future = bookings.where('paid = false OR paid IS NULL OR start_time >= ?', Date.current).order("start_time ASC")
  return @future
end

def unpaid_bookings
  @unpaid = bookings.where('(paid IS NULL OR paid = false) AND start_time <= ?', Date.current).order("start_time ASC")
end

def full_name
  self.first_name + " " + self.last_name
end

def self.find_all_by_name_containing(text)
  self.where("LOWER(first_name || ' ' || last_name) LIKE ? AND NOT archived", "%#{text.downcase}%")
end
  
def isValidMember
  if !self.trial_date
    self.trial_date = self.created_at
  end
  
  if (self.membership_type.membership_type == 'trial' && self.trial_date < 1.day.ago) || self.archived
    return false
  else
    return true
  end
end

def isArchived
  return self.archived
end

def trialExpires
  if self.membership_type.membership_type == 'trial' 
    if !self.trial_date
      self.trial_date = self.created_at + 3.months
    end    
    difference = (Date.current - self.trial_date.to_date).to_i #trial is 90 days long
    if difference > 0
      return "(Trial expired " + difference.abs.to_s + " days ago)"
    else
      return "(Trial expires in " + difference.abs.to_s + " days time)"
    end
  end
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
      where('last_name || first_name ILIKE ? AND NOT archived', "%#{search}%")  
    else  
      all  
    end  
end

end
