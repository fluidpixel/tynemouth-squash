# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2021_10_13_075214) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.integer "court_id"
    t.integer "player_id"
    t.integer "vs_player_id"
    t.integer "time_slot_id"
    t.datetime "start_time", precision: nil
    t.integer "court_time"
    t.boolean "paid", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "guest_booking"
    t.boolean "cancelled", default: false
    t.index ["paid"], name: "index_bookings_on_paid", where: "((paid = false) OR (paid IS NULL))"
    t.index ["start_time"], name: "index_bookings_on_start_time"
  end

  create_table "courts", force: :cascade do |t|
    t.string "court_name"
    t.integer "time_slot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fixtures", force: :cascade do |t|
    t.bigint "league_id"
    t.integer "player_a_id"
    t.integer "player_b_id"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["league_id"], name: "index_fixtures_on_league_id"
  end

  create_table "leagues", force: :cascade do |t|
    t.integer "league_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "membership_types", force: :cascade do |t|
    t.string "membership_type"
    t.float "court_cost"
    t.float "membership_cost"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "landline"
    t.string "mobile"
    t.string "email"
    t.string "membership_number"
    t.integer "membership_type_id"
    t.boolean "admin"
    t.datetime "trial_date", precision: nil
    t.string "address_line1"
    t.string "address_line2"
    t.string "address_line3"
    t.string "post_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "super_admin"
    t.boolean "archived", default: false
    t.bigint "league_id"
    t.datetime "date_added_to_league", precision: nil
    t.boolean "active_membership", default: true
    t.index ["last_name"], name: "index_players_on_last_name"
    t.index ["league_id"], name: "index_players_on_league_id"
  end

  create_table "scores", force: :cascade do |t|
    t.integer "first", default: 0
    t.integer "second", default: 0
    t.bigint "fixture_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fixture_id"], name: "index_scores_on_fixture_id"
  end

  create_table "time_slots", force: :cascade do |t|
    t.time "time"
    t.integer "court_id"
    t.boolean "weekday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "bank_holiday", default: true
    t.boolean "sunday", default: true
    t.boolean "covid_slot", default: false
    t.boolean "cleaning", default: false
    t.index ["time"], name: "index_time_slots_on_time"
  end

end
