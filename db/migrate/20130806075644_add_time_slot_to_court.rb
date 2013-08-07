class AddTimeSlotToCourt < ActiveRecord::Migration
  def change
    add_column :courts, :timeSlot, :time
  end
end
