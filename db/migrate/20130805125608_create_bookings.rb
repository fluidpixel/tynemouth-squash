class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :courtId
      t.integer :playerID
      t.datetime :startTime
      t.integer :courtTime

      t.timestamps
    end
  end
end
