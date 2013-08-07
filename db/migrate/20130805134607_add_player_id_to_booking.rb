class AddPlayerIdToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :player_id, :integer
  end
end
