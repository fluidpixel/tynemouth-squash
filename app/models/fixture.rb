class Fixture < ActiveRecord::Base
  belongs_to :league
  has_one :score
end
