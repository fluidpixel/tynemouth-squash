#reset
# TimeSlot.delete_all
# remove the last timeslots for each court
TimeSlot.where(time: Time.zone.parse('22:40'), court_id: 5).destroy
TimeSlot.where(time: Time.zone.parse('23:20'), court_id: 5).destroy
TimeSlot.where(time: Time.zone.parse('22:00'), court_id: 1).destroy
TimeSlot.where(time: Time.zone.parse('22:40'), court_id: 1).destroy
TimeSlot.where(time: Time.zone.parse('22:10'), court_id: 2).destroy
TimeSlot.where(time: Time.zone.parse('22:50'), court_id: 2).destroy
TimeSlot.where(time: Time.zone.parse('22:20'), court_id: 3).destroy
TimeSlot.where(time: Time.zone.parse('23:00'), court_id: 3).destroy
TimeSlot.where(time: Time.zone.parse('22:30'), court_id: 4).destroy
TimeSlot.where(time: Time.zone.parse('23:10'), court_id: 4).destroy
TimeSlot.where(time: Time.zone.parse('22:40'), court_id: 5).destroy
TimeSlot.where(time: Time.zone.parse('23:20'), court_id: 5).destroy

# create morning slots for the weekend
TimeSlot.create([
{ time: Time.zone.parse('09:00'), weekday: false, court_id: 1, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('09:40'), weekday: false, court_id: 1, bank_holiday: false, covid_slot: true, cleaning: true},
{ time: Time.zone.parse('10:00'), weekday: false, court_id: 1, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('10:40'), weekday: false, court_id: 1, bank_holiday: false, covid_slot: true, cleaning: true},
{ time: Time.zone.parse('11:00'), weekday: false, court_id: 1, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('11:40'), weekday: false, court_id: 1, bank_holiday: false, covid_slot: true, cleaning: true},

{ time: Time.zone.parse('09:10'), weekday: false, court_id: 2, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('09:50'), weekday: false, court_id: 2, bank_holiday: false, covid_slot: true, cleaning: true},
{ time: Time.zone.parse('10:10'), weekday: false, court_id: 2, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('10:50'), weekday: false, court_id: 2, bank_holiday: false, covid_slot: true, cleaning: true},
{ time: Time.zone.parse('11:10'), weekday: false, court_id: 2, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('11:50'), weekday: false, court_id: 2, bank_holiday: false, covid_slot: true, cleaning: true},

{ time: Time.zone.parse('09:20'), weekday: false, court_id: 3, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('10:00'), weekday: false, court_id: 3, bank_holiday: false, covid_slot: true, cleaning: true},
{ time: Time.zone.parse('10:20'), weekday: false, court_id: 3, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('11:00'), weekday: false, court_id: 3, bank_holiday: false, covid_slot: true, cleaning: true},
{ time: Time.zone.parse('11:20'), weekday: false, court_id: 3, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('12:00'), weekday: false, court_id: 3, bank_holiday: false, covid_slot: true, cleaning: true},

{ time: Time.zone.parse('09:30'), weekday: false, court_id: 4, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('10:10'), weekday: false, court_id: 4, bank_holiday: false, covid_slot: true, cleaning: true},
{ time: Time.zone.parse('10:30'), weekday: false, court_id: 4, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('11:10'), weekday: false, court_id: 4, bank_holiday: false, covid_slot: true, cleaning: true},
{ time: Time.zone.parse('11:30'), weekday: false, court_id: 4, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('12:10'), weekday: false, court_id: 4, bank_holiday: false, covid_slot: true, cleaning: true},

{ time: Time.zone.parse('09:40'), weekday: false, court_id: 5, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('10:20'), weekday: false, court_id: 5, bank_holiday: false, covid_slot: true, cleaning: true},
{ time: Time.zone.parse('10:40'), weekday: false, court_id: 5, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('11:20'), weekday: false, court_id: 5, bank_holiday: false, covid_slot: true, cleaning: true},
{ time: Time.zone.parse('11:40'), weekday: false, court_id: 5, bank_holiday: false, covid_slot: true},
{ time: Time.zone.parse('12:20'), weekday: false, court_id: 5, bank_holiday: false, covid_slot: true, cleaning: true},
])








