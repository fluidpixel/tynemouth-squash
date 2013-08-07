class AddTimeSlotToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :timeSlot, :reference
  end
end
