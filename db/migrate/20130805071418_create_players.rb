class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :tel
      t.string :membership_number
      t.boolean :admin
      
      t.timestamps
    end
  end
end
