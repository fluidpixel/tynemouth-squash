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
end
