class AddTimeSlotIdToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :timeSlot_id, :references
  end
end
