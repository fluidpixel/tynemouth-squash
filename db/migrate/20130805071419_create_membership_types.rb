class CreateMembershipTypes < ActiveRecord::Migration[6.0]
  def change
    create_table :membership_types do |t|
      t.string :membership_type
      t.float :court_cost
      t.float :membership_cost
      
      t.timestamps
    end
  end
end