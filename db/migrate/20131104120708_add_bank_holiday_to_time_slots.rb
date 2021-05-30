class AddBankHolidayToTimeSlots < ActiveRecord::Migration[6.0]
  def change
    add_column :time_slots, :bank_holiday, :boolean, :default => true
  end
end
