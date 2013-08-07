class CreateCourts < ActiveRecord::Migration
  def change
    create_table :courts do |t|
      t.string :courtName

      t.timestamps
    end
  end
end
