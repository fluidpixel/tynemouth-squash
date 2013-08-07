class AddCourttoTimeSlots < ActiveRecord::Migration
  def change
	  add_column :time_slots, :court_id, :reference
  end
end
