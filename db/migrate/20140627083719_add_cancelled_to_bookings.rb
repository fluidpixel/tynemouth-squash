class AddCancelledToBookings < ActiveRecord::Migration[6.0]
  def change
    add_column :bookings, :cancelled, :boolean
  end
end
