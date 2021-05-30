class AddArchivedToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :archived, :boolean, :default => false
  end
end
