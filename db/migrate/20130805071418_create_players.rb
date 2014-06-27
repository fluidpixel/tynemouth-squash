class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :landline
      t.string :mobile
      t.string :email
      t.string :membership_number
      t.integer :membership_type_id
      t.boolean :admin
      t.datetime :trial_date
      t.string   :address_line1
      t.string   :address_line2
      t.string   :address_line3
      t.string   :post_code
      t.timestamps
    end
  end
end