class AddCovidToTimeSlots < ActiveRecord::Migration[6.0]
  def change
    add_column :time_slots, :covid_slot, :boolean, :default => false
    add_column :time_slots, :cleaning, :boolean, :default => false
  end
end
