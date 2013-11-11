class AddBankHolidayToTimeSlots < ActiveRecord::Migration
  def change
    add_column :time_slots, :bank_holiday, :boolean, :default => true
  end
end
