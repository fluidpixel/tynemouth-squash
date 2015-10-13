class AddDateAddedToLeagueToPlayers < ActiveRecord::Migration
  def change
      add_column :players, :date_added_to_league, :datetime
  end
end
