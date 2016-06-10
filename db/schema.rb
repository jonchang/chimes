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

ActiveRecord::Schema.define(version: 20160610050211) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "conferences", force: :cascade do |t|
    t.string   "name"
    t.string   "time_zone",     default: "UTC"
    t.binary   "start_chime"
    t.binary   "warning_chime"
    t.binary   "passing_chime"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "event_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "length"
    t.integer  "warning_time"
    t.integer  "passing_time"
    t.integer  "conference_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "event_types", ["conference_id"], name: "index_event_types_on_conference_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.datetime "datetime"
    t.integer  "event_type_id"
    t.integer  "room_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "events", ["event_type_id"], name: "index_events_on_event_type_id", using: :btree
  add_index "events", ["room_id"], name: "index_events_on_room_id", using: :btree

  create_table "managers", force: :cascade do |t|
    t.boolean  "admin"
    t.integer  "user_id"
    t.integer  "conference_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "managers", ["conference_id"], name: "index_managers_on_conference_id", using: :btree
  add_index "managers", ["user_id"], name: "index_managers_on_user_id", using: :btree

  create_table "rooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "conference_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "rooms", ["conference_id"], name: "index_rooms_on_conference_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "event_types", "conferences"
  add_foreign_key "events", "event_types"
  add_foreign_key "events", "rooms"
  add_foreign_key "managers", "conferences"
  add_foreign_key "managers", "users"
  add_foreign_key "rooms", "conferences"
end
