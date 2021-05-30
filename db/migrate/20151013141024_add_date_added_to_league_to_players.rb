class AddDateAddedToLeagueToPlayers < ActiveRecord::Migration[6.0]
  def change
      add_column :players, :date_added_to_league, :datetime
  end
end
