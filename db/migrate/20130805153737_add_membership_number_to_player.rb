class AddMembershipNumberToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :membershipNumber, :int
  end
end
