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

ActiveRecord::Schema.define(version: 20130807094612) do

# Could not dump table "bookings" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

# Could not dump table "courts" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

  create_table "players", force: true do |t|
    t.string   "firstName"
    t.string   "lastName"
    t.string   "tel"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "membershipNumber"
  end

# Could not dump table "time_slots" because of following NoMethodError
#   undefined method `[]' for nil:NilClass

end
