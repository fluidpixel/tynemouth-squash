# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150201224035) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: true do |t|
    t.integer  "court_id"
    t.integer  "player_id"
    t.integer  "vs_player_id"
    t.integer  "time_slot_id"
    t.datetime "start_time"
    t.integer  "court_time"
    t.boolean  "paid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "guest_booking"
    t.boolean  "cancelled"
  end

  add_index "bookings", ["paid"], name: "index_bookings_on_paid", where: "(paid = false)", using: :btree
  add_index "bookings", ["start_time"], name: "index_bookings_on_start_time", using: :btree

  create_table "courts", force: true do |t|
    t.string   "court_name"
    t.integer  "time_slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "membership_types", force: true do |t|
    t.string   "membership_type"
    t.float    "court_cost"
    t.float    "membership_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "landline"
    t.string   "mobile"
    t.string   "email"
    t.datetime "trial_date"
    t.string   "address_line1"
    t.string   "address_line2"
    t.string   "address_line3"
    t.string   "post_code"
    t.string   "membership_number"
    t.integer  "membership_type_id"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "super_admin"
  end

  add_index "players", ["last_name"], name: "index_players_on_last_name", using: :btree

  create_table "time_slots", force: true do |t|
    t.time     "time"
    t.integer  "court_id"
    t.boolean  "weekday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "bank_holiday", default: true
    t.boolean  "sunday",       default: true
  end

  add_index "time_slots", ["time"], name: "index_time_slots_on_time", using: :btree

end
