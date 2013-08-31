class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :telephone
      t.string :email
      t.string :membership_number
      t.integer :membership_type_id
      t.boolean :admin
      
      t.timestamps
    end
  end
end