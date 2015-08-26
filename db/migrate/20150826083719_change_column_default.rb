class ChangeColumnDefault < ActiveRecord::Migration
  def change
    change_column_default :bookings, :paid, false
    change_column_default :bookings, :cancelled, false
  end
end
