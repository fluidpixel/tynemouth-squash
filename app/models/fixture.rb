class Fixture < ActiveRecord::Base
  has_one :score, :dependent => :destroy
  belongs_to :league
  belongs_to :playerA, class_name: "Player"
  belongs_to :playerB, class_name: "Player"
end