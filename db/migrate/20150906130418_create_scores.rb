class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :first
      t.integer :second
      t.timestamps
    end
  end
end
