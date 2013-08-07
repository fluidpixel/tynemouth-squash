class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :firstName
      t.string :lastName
      t.string :tel

      t.timestamps
    end
  end
end
