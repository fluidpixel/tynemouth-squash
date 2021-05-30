class AddSuperAdminToPlayers < ActiveRecord::Migration[6.0]
  def change
    add_column :players, :super_admin, :boolean
  end
end
