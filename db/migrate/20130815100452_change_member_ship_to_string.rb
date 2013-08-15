class ChangeMemberShipToString < ActiveRecord::Migration
  def change
	  change_column :players, :membership_number, :string
  end
end
