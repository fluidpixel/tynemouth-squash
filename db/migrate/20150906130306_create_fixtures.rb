class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.belongs_to :league
      t.integer :player_a_id
      t.integer :player_b_id
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
