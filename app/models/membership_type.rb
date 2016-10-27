class MembershipType < ActiveRecord::Base

has_many :players

validates_presence_of :membership_type

validates_numericality_of :court_cost, greater_than_or_equal_to: 0
end