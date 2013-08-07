class AddCourtIdToBooking < ActiveRecord::Migration
  def change
    add_column :bookings, :court_id, :reference
  end
end
