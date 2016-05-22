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

ActiveRecord::Schema.define(version: 20160522185120) do

  create_table "activity_rules", force: :cascade do |t|
    t.integer  "games_limit"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "addresses", force: :cascade do |t|
    t.string  "city"
    t.string  "zip_code"
    t.string  "street_address"
    t.integer "addressable_id"
    t.string  "addressable_type"
  end

  add_index "addresses", ["addressable_type", "addressable_id"], name: "index_addresses_on_addressable_type_and_addressable_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "matches", force: :cascade do |t|
    t.integer  "white_player_id"
    t.integer  "black_player_id"
    t.integer  "round"
    t.string   "result"
    t.integer  "tournament_id"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "white_rating_change"
    t.integer  "black_rating_change"
  end

  create_table "players", force: :cascade do |t|
    t.string   "email",                   default: "",    null: false
    t.string   "encrypted_password",      default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",           default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.boolean  "admin",                   default: false
    t.string   "first_name"
    t.string   "surname"
    t.date     "date_of_birth"
    t.integer  "rating",                  default: 1700
    t.integer  "development_coefficient", default: 40
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true
  add_index "players", ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true

  create_table "players_tournaments", id: false, force: :cascade do |t|
    t.integer "player_id"
    t.integer "tournament_id"
  end

  add_index "players_tournaments", ["player_id"], name: "index_players_tournaments_on_player_id"
  add_index "players_tournaments", ["tournament_id"], name: "index_players_tournaments_on_tournament_id"

  create_table "rating_rules", force: :cascade do |t|
    t.integer  "min_rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start_date"
    t.string   "tournament_type"
    t.integer  "rounds"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "round"
    t.integer  "rule_id"
    t.string   "rule_type"
  end

  add_index "tournaments", ["rule_type", "rule_id"], name: "index_tournaments_on_rule_type_and_rule_id"

end
