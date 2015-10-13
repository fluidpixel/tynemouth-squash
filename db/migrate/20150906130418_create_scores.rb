class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :first, :default => 0
      t.integer :second, :default => 0
      t.belongs_to :fixture
      t.timestamps
    end
  end
end
