class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :court_id
      t.integer :player_id
      t.integer :time_slot_id
      t.datetime :start_time
      t.integer :court_time
      t.boolean :paid

      t.timestamps
    end
  end
end
