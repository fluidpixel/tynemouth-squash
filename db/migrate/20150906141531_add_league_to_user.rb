class AddLeagueToUser < ActiveRecord::Migration
  def change
    add_reference :players, :league, index: true
  end
end
