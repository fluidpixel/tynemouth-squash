class CreateTimeSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :time_slots do |t|
      t.time :time
      t.integer :court_id
      t.boolean :weekday
      
      t.timestamps
    end
  end
end
