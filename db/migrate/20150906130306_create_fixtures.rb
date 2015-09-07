class CreateFixtures < ActiveRecord::Migration
  def change
    create_table :fixtures do |t|
      t.timestamps
    end
  end
end
