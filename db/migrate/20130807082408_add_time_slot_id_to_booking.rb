class AddTimeSlotIdToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :timeSlot_id, :reference
  end
end
