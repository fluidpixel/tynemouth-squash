class CreateCourts < ActiveRecord::Migration[6.0]
  def change
    create_table :courts do |t|
      t.string :court_name
      t.integer :time_slot_id

      t.timestamps
    end
  end
end
