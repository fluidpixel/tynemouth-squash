class ChangePlayerIdColumnType < ActiveRecord::Migration
  def change
	change_column :bookings, :player_id, :references 
  end
end
