# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TimeSlot.delete_all
Booking.delete_all
Player.delete_all
Court.delete_all

Player.create([
{ first_name: 'Stuart', last_name: 'Varrall', tel: '0191', membership_number: '100'}
])

Court.create([
{ court_name: 'Court 1'},
{ court_name: 'Court 2'},
{ court_name: 'Court 3'},
{ court_name: 'Court 4'},
{ court_name: 'Court 5'},
])

TimeSlot.create([
{ time: Time.zone.parse('10:00'), court_id: 1},
{ time: Time.zone.parse('10:40'), court_id: 1},
{ time: Time.zone.parse('11:20'), court_id: 1},
{ time: Time.zone.parse('12:00'), court_id: 1},
{ time: Time.zone.parse('12:40'), court_id: 1},
{ time: Time.zone.parse('13:20'), court_id: 1},
{ time: Time.zone.parse('14:00'), court_id: 1},

{ time: Time.zone.parse('10:05'), court_id: 2},
{ time: Time.zone.parse('10:45'), court_id: 2},
{ time: Time.zone.parse('11:25'), court_id: 2},
{ time: Time.zone.parse('12:05'), court_id: 2},
{ time: Time.zone.parse('12:45'), court_id: 2},
{ time: Time.zone.parse('13:25'), court_id: 2},
{ time: Time.zone.parse('14:05'), court_id: 2},

{ time: Time.zone.parse('10:00'), court_id: 3},
{ time: Time.zone.parse('10:40'), court_id: 3},
{ time: Time.zone.parse('11:20'), court_id: 3},
{ time: Time.zone.parse('12:00'), court_id: 3},
{ time: Time.zone.parse('12:40'), court_id: 3},
{ time: Time.zone.parse('13:20'), court_id: 3},
{ time: Time.zone.parse('14:00'), court_id: 3},

{ time: Time.zone.parse('10:00'), court_id: 4},
{ time: Time.zone.parse('10:40'), court_id: 4},
{ time: Time.zone.parse('11:20'), court_id: 4},
{ time: Time.zone.parse('12:00'), court_id: 4},
{ time: Time.zone.parse('12:40'), court_id: 4},
{ time: Time.zone.parse('13:20'), court_id: 4},
{ time: Time.zone.parse('14:00'), court_id: 4},

{ time: Time.zone.parse('10:00'), court_id: 5},
{ time: Time.zone.parse('10:40'), court_id: 5},
{ time: Time.zone.parse('11:20'), court_id: 5},
{ time: Time.zone.parse('12:00'), court_id: 5},
{ time: Time.zone.parse('12:40'), court_id: 5},
{ time: Time.zone.parse('13:20'), court_id: 5},
{ time: Time.zone.parse('14:00'), court_id: 5},
])