class CreateTimeSlots < ActiveRecord::Migration
  def change
    create_table :time_slots do |t|
      t.time :time
      t.integer :court_id
      
      t.timestamps
    end
  end
end
