class Court < ActiveRecord::Base

has_many :bookings
has_many :timeSlots

validates :court_name, presence: true,
                    length: { minimum: 1 }

end
