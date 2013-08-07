class TimeSlot < ActiveRecord::Base
	belongs_to :court
	has_many :bookings
end
