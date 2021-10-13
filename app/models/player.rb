class Player < ActiveRecord::Base

has_many :bookings, :dependent => :destroy
# has_many :fixtureA, :class_name => 'Fixture', :dependent => :destroy, :foreign_key => 'player_a_id'
has_many :vs_bookings, :foreign_key => 'vs_player_id', :class_name => 'Booking', :dependent => :destroy
# has_many :fixtureB, :class_name => 'Fixture', :dependent => :destroy, :foreign_key => 'player_b_id'
# scope :fixture, lambda {|father_id, mother_id| where('father_id = ? AND mother_id = ?', father_id, mother_id) }

has_many :results, through: :fixtures
belongs_to :league
belongs_to :membership_type

validates_presence_of :membership_number, :membership_type, :on => :create
validates_presence_of :last_name
validates_uniqueness_of :membership_number

def fixtures
  Fixture.where('player_a_id = ? OR player_b_id = ?', self.id, self.id)
end


def self.authenticate(last_name, membership_number)
  if !last_name.blank? && !membership_number.blank?
    player = Player.where("lower(last_name) = ? AND lower(membership_number) = ?", last_name.downcase, membership_number.downcase).first
    if player
      player
    # elsif membership_number == "xxx"
#       player = Player.where("lower(last_name) = ?", last_name.downcase).first
#       if player
#         return player
#       end
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
    first_name = name.split(" ")[0]
    if !last_name.blank?
      player = Player.where("lower(first_name) = ? AND lower(last_name) = ? AND lower(membership_number) = ?", first_name.downcase, last_name.downcase, membership_number.downcase).first
      if player
        return player
      elsif membership_number == "xxx"
        player = Player.where("lower(first_name) = ? AND lower(last_name) = ? AND NOT archived", first_name.downcase, last_name.downcase).first
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

def bookings_after(date)
  bookings.where("start_time >= ?", date).order("start_time ASC")
end

def future_bookings
  bookings.where("((paid = false OR paid IS NULL) AND start_time >= ? AND DATE_PART('hour', start_time) >= 16 AND DATE_PART('hour', start_time) < 21 AND NOT DATE_PART('dow', start_time) = 0 AND NOT DATE_PART('dow', start_time) = 6) OR start_time >= ?", Date.new(2015, 11, 1), Date.current).order("start_time ASC")
end

def unpaid_bookings
  bookings.where("(paid IS NULL OR paid = false) AND start_time <= ? AND start_time >= ? AND DATE_PART('hour', start_time) >= 16 AND DATE_PART('hour', start_time) < 21 AND NOT DATE_PART('dow', start_time) = 0 AND NOT DATE_PART('dow', start_time) = 6", Date.current, Date.new(2015, 11, 1)).order("start_time ASC")
end

def future_vs_bookings
  bookings.where("start_time >= ?", Date.current).order("start_time ASC")
end

def full_name
  if self.first_name && self.last_name
    self.first_name + " " + self.last_name
  end
end

def self.find_all_by_name_containing(text)
  self.where("first_name || ' ' || last_name ILIKE ? AND NOT archived", "%#{text}%")
end
  
def isValidMember
  if !self.trial_date
    self.trial_date = self.created_at
  end
  
  if (!self.membership_type.active_membership && self.membership_type.membership_type != 'trial')
    return false
  end

  if (self.membership_type.membership_type == 'trial' && self.trial_date < 1.day.ago) || self.archived
    return false
  else
    return true
  end
end

def isArchived
  self.archived
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

def isFineable
  if self.membership_type.membership_type == 'class' || self.membership_type.membership_type == 'team' || self.membership_type.membership_type == 'competition'
    return false
  else
    return true
  end
end
  
def self.search(search)  
    if search  
      where("first_name || ' ' || last_name ILIKE ? AND NOT archived", "%#{search}%")  
    else  
      all  
    end  
end

end
