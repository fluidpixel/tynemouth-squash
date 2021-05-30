class ChangeMemberShipToString < ActiveRecord::Migration[6.0]
  def change
	  change_column :players, :membership_number, :string
  end
end
