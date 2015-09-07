class CreateLeagues < ActiveRecord::Migration
  def change
    create_table :leagues do |t|
      t.integer :league_number
      t.timestamps
    end
  end
end
