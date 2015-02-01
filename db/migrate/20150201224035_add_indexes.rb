class AddIndexes < ActiveRecord::Migration
  def change
    add_index :players, :last_name, order: { last_name: "ASC" }
    add_index :bookings, :paid, where: "paid = false"
    add_index :bookings, :start_time, order: { start_time: "ASC" }
    add_index :time_slots, :time, order: { time: "ASC" }
  end
end