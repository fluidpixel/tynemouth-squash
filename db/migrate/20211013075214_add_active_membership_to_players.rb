class AddActiveMembershipToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :active_membership, :boolean, :default => true
  end
end
