class ChangeTimeSlotColoumType < ActiveRecord::Migration
  def change
	change_column :courts, :timeSlot, :reference  
  end
end
