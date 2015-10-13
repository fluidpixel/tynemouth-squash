class Fixture < ActiveRecord::Base
  
  belongs_to :league
  belongs_to :player_a, class_name: "Player"
  belongs_to :player_b, class_name: "Player"
  
  has_one :score, :dependent => :destroy
  
  accepts_nested_attributes_for :score
  
end