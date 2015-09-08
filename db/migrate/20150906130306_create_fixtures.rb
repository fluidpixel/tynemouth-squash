class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.belongs_to :league
      t.datetime :start_date
      t.datetime :end_date
      t.timestamps
    end
  end
end
