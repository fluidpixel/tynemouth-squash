class AddGuestBookingToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :guest_booking, :boolean
  end
end
