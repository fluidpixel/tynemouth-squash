class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :first
      t.integer :second
      t.belongs_to :fixture
      t.timestamps
    end
  end
end
