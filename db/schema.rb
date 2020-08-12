# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_11_115953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", id: :serial, force: :cascade do |t|
    t.integer "court_id"
    t.integer "player_id"
    t.integer "vs_player_id"
    t.integer "time_slot_id"
    t.datetime "start_time"
    t.integer "court_time"
    t.boolean "paid", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "guest_booking"
    t.boolean "cancelled", default: false
    t.index ["paid"], name: "index_bookings_on_paid", where: "(paid = false)"
    t.index ["start_time"], name: "index_bookings_on_start_time"
  end

  create_table "courts", id: :serial, force: :cascade do |t|
    t.string "court_name", limit: 255
    t.integer "time_slot_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "fixtures", id: :serial, force: :cascade do |t|
    t.integer "league_id"
    t.integer "player_a_id"
    t.integer "player_b_id"
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues", id: :serial, force: :cascade do |t|
    t.integer "league_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "membership_types", id: :serial, force: :cascade do |t|
    t.string "membership_type", limit: 255
    t.float "court_cost"
    t.float "membership_cost"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "players", id: :serial, force: :cascade do |t|
    t.string "first_name", limit: 255
    t.string "last_name", limit: 255
    t.string "landline", limit: 255
    t.string "mobile", limit: 255
    t.string "email", limit: 255
    t.datetime "trial_date"
    t.string "address_line1", limit: 255
    t.string "address_line2", limit: 255
    t.string "address_line3", limit: 255
    t.string "post_code", limit: 255
    t.string "membership_number", limit: 255
    t.integer "membership_type_id"
    t.boolean "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "super_admin"
    t.boolean "archived", default: false
    t.integer "league_id"
    t.datetime "date_added_to_league"
    t.index ["last_name"], name: "index_players_on_last_name"
    t.index ["league_id"], name: "index_players_on_league_id"
  end

  create_table "scores", id: :serial, force: :cascade do |t|
    t.integer "first", default: 0
    t.integer "second", default: 0
    t.integer "fixture_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "time_slots", id: :serial, force: :cascade do |t|
    t.time "time"
    t.integer "court_id"
    t.boolean "weekday"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "bank_holiday", default: true
    t.boolean "sunday", default: true
    t.boolean "covid_slot", default: false
    t.boolean "cleaning", default: false
    t.index ["time"], name: "index_time_slots_on_time"
  end

end
