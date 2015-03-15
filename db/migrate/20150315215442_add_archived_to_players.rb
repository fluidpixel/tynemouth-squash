class AddArchivedToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :archived, :boolean, :default => false
  end
end
