class AddPaidToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :paid, :boolean
  end
end
