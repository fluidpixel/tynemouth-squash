# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MembershipType.create([
  { membership_type: 'country', court_cost: '6.00', membership_cost: '1000'},
  { membership_type: 'family', court_cost: '6.00', membership_cost: '1000'},
  { membership_type: 'junior', court_cost: '3.00', membership_cost: '1000'},
  { membership_type: 'couple', court_cost: '6.00', membership_cost: '1000'},
])

Player.create([
{ first_name: 'Stuart', last_name: 'Varrall', telephone: '0191', membership_number: '100', membership_type_id: '3', admin: 'true'}
])

Court.create([
{ court_name: 'Court 1'},
{ court_name: 'Court 2'},
{ court_name: 'Court 3'},
{ court_name: 'Court 4'},
{ court_name: 'Court 5'},
])

#weekdays
TimeSlot.create([
{ time: Time.zone.parse('09:10'), weekday: false, court_id: 1},
{ time: Time.zone.parse('09:50'), weekday: false, court_id: 1},
{ time: Time.zone.parse('10:30'), weekday: false, court_id: 1},
{ time: Time.zone.parse('11:10'), weekday: false, court_id: 1},
{ time: Time.zone.parse('11:50'), weekday: false, court_id: 1},
{ time: Time.zone.parse('12:30'), weekday: true, court_id: 1},
{ time: Time.zone.parse('13:10'), weekday: true, court_id: 1},
{ time: Time.zone.parse('13:50'), weekday: true, court_id: 1},
{ time: Time.zone.parse('14:30'), weekday: true, court_id: 1},
{ time: Time.zone.parse('15:10'), weekday: true, court_id: 1},
{ time: Time.zone.parse('15:50'), weekday: true, court_id: 1},
{ time: Time.zone.parse('16:30'), weekday: true, court_id: 1},
{ time: Time.zone.parse('17:10'), weekday: true, court_id: 1},
{ time: Time.zone.parse('17:50'), weekday: true, court_id: 1},
{ time: Time.zone.parse('18:30'), weekday: true, court_id: 1},
{ time: Time.zone.parse('19:10'), weekday: true, court_id: 1},
{ time: Time.zone.parse('19:50'), weekday: true, court_id: 1},
{ time: Time.zone.parse('20:30'), weekday: true, court_id: 1},
{ time: Time.zone.parse('21:10'), weekday: true, court_id: 1},
{ time: Time.zone.parse('21:50'), weekday: true, court_id: 1},

{ time: Time.zone.parse('09:10'), weekday: false, court_id: 2},
{ time: Time.zone.parse('09:50'), weekday: false, court_id: 2},
{ time: Time.zone.parse('10:30'), weekday: false, court_id: 2},
{ time: Time.zone.parse('11:10'), weekday: false, court_id: 2},
{ time: Time.zone.parse('11:50'), weekday: false, court_id: 2},
{ time: Time.zone.parse('12:30'), weekday: true, court_id: 2},
{ time: Time.zone.parse('13:10'), weekday: true, court_id: 2},
{ time: Time.zone.parse('13:50'), weekday: true, court_id: 2},
{ time: Time.zone.parse('14:30'), weekday: true, court_id: 2},
{ time: Time.zone.parse('15:10'), weekday: true, court_id: 2},
{ time: Time.zone.parse('15:50'), weekday: true, court_id: 2},
{ time: Time.zone.parse('16:30'), weekday: true, court_id: 2},
{ time: Time.zone.parse('17:10'), weekday: true, court_id: 2},
{ time: Time.zone.parse('17:50'), weekday: true, court_id: 2},
{ time: Time.zone.parse('18:30'), weekday: true, court_id: 2},
{ time: Time.zone.parse('19:10'), weekday: true, court_id: 2},
{ time: Time.zone.parse('19:50'), weekday: true, court_id: 2},
{ time: Time.zone.parse('20:30'), weekday: true, court_id: 2},
{ time: Time.zone.parse('21:10'), weekday: true, court_id: 2},
{ time: Time.zone.parse('21:50'), weekday: true, court_id: 2},

{ time: Time.zone.parse('09:00'), weekday: false, court_id: 3},
{ time: Time.zone.parse('09:40'), weekday: false, court_id: 3},
{ time: Time.zone.parse('10:20'), weekday: false, court_id: 3},
{ time: Time.zone.parse('11:00'), weekday: false, court_id: 3},
{ time: Time.zone.parse('11:40'), weekday: false, court_id: 3},
{ time: Time.zone.parse('12:20'), weekday: true, court_id: 3},
{ time: Time.zone.parse('13:00'), weekday: true, court_id: 3},
{ time: Time.zone.parse('13:40'), weekday: true, court_id: 3},
{ time: Time.zone.parse('14:20'), weekday: true, court_id: 3},
{ time: Time.zone.parse('15:00'), weekday: true, court_id: 3},
{ time: Time.zone.parse('15:40'), weekday: true, court_id: 3},
{ time: Time.zone.parse('16:20'), weekday: true, court_id: 3},
{ time: Time.zone.parse('17:00'), weekday: true, court_id: 3},
{ time: Time.zone.parse('17:40'), weekday: true, court_id: 3},
{ time: Time.zone.parse('18:20'), weekday: true, court_id: 3},
{ time: Time.zone.parse('19:00'), weekday: true, court_id: 3},
{ time: Time.zone.parse('19:40'), weekday: true, court_id: 3},
{ time: Time.zone.parse('20:20'), weekday: true, court_id: 3},
{ time: Time.zone.parse('21:00'), weekday: true, court_id: 3},
{ time: Time.zone.parse('21:40'), weekday: true, court_id: 3},

{ time: Time.zone.parse('09:00'), weekday: false, court_id: 4},
{ time: Time.zone.parse('09:40'), weekday: false, court_id: 4},
{ time: Time.zone.parse('10:20'), weekday: false, court_id: 4},
{ time: Time.zone.parse('11:00'), weekday: false, court_id: 4},
{ time: Time.zone.parse('11:40'), weekday: false, court_id: 4},
{ time: Time.zone.parse('12:20'), weekday: true, court_id: 4},
{ time: Time.zone.parse('13:00'), weekday: true, court_id: 4},
{ time: Time.zone.parse('13:40'), weekday: true, court_id: 4},
{ time: Time.zone.parse('14:20'), weekday: true, court_id: 4},
{ time: Time.zone.parse('15:00'), weekday: true, court_id: 4},
{ time: Time.zone.parse('15:40'), weekday: true, court_id: 4},
{ time: Time.zone.parse('16:20'), weekday: true, court_id: 4},
{ time: Time.zone.parse('17:00'), weekday: true, court_id: 4},
{ time: Time.zone.parse('17:40'), weekday: true, court_id: 4},
{ time: Time.zone.parse('18:20'), weekday: true, court_id: 4},
{ time: Time.zone.parse('19:00'), weekday: true, court_id: 4},
{ time: Time.zone.parse('19:40'), weekday: true, court_id: 4},
{ time: Time.zone.parse('20:20'), weekday: true, court_id: 4},
{ time: Time.zone.parse('21:00'), weekday: true, court_id: 4},
{ time: Time.zone.parse('21:40'), weekday: true, court_id: 4},

{ time: Time.zone.parse('09:05'), weekday: false, court_id: 5},
{ time: Time.zone.parse('09:45'), weekday: false, court_id: 5},
{ time: Time.zone.parse('10:25'), weekday: false, court_id: 5},
{ time: Time.zone.parse('11:05'), weekday: false, court_id: 5},
{ time: Time.zone.parse('11:45'), weekday: false, court_id: 5},
{ time: Time.zone.parse('12:25'), weekday: true, court_id: 5},
{ time: Time.zone.parse('13:05'), weekday: true, court_id: 5},
{ time: Time.zone.parse('13:45'), weekday: true, court_id: 5},
{ time: Time.zone.parse('14:25'), weekday: true, court_id: 5},
{ time: Time.zone.parse('15:05'), weekday: true, court_id: 5},
{ time: Time.zone.parse('15:45'), weekday: true, court_id: 5},
{ time: Time.zone.parse('16:25'), weekday: true, court_id: 5},
{ time: Time.zone.parse('17:05'), weekday: true, court_id: 5},
{ time: Time.zone.parse('17:45'), weekday: true, court_id: 5},
{ time: Time.zone.parse('18:25'), weekday: true, court_id: 5},
{ time: Time.zone.parse('19:05'), weekday: true, court_id: 5},
{ time: Time.zone.parse('19:45'), weekday: true, court_id: 5},
{ time: Time.zone.parse('20:25'), weekday: true, court_id: 5},
{ time: Time.zone.parse('21:05'), weekday: true, court_id: 5},
{ time: Time.zone.parse('21:45'), weekday: true, court_id: 5},
])

#weekdays