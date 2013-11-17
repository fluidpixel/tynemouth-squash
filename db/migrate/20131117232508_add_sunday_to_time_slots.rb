class AddSundayToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :sunday, :boolean, :default => true
    TimeSlot.reset_column_information
    TimeSlot.update_all(:sunday => true)
  end
end
