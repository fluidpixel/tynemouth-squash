class CreateLeagues < ActiveRecord::Migration[6.0]
  def change
    create_table :leagues do |t|
      t.integer :league_number
      t.timestamps
    end
  end
end
