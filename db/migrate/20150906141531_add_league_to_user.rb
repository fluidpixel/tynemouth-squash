class AddLeagueToUser < ActiveRecord::Migration[6.0]
  def change
    add_reference :players, :league, index: true
  end
end
