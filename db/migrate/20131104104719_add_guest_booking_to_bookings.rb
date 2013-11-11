class AddGuestBookingToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :guest_booking, :boolean
  end
end
