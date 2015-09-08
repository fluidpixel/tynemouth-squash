class Score < ActiveRecord::Base
  belongs_to :fixture, :dependent => :destroy
end