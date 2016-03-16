class League < ActiveRecord::Base
  
  has_many :players
  has_many :fixtures, :dependent => :destroy
  
  accepts_nested_attributes_for :players
  
  def league_name
    if self.league_number == 0
      "Premier League"
    else
      "League " + self.league_number.to_s
    end 
  end
  
  def league_short_name
    if self.league_number == 0
      "P"
    else
      self.league_number.to_s
    end 
  end
  
  def sorted_players
    return self.players.order("date_added_to_league")
  end
  
  # def points_sorted_players
  #   return self.players.order("date_added_to_league")
  # end
end
