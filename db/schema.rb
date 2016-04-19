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

ActiveRecord::Schema.define(version: 20160419141148) do

  create_table "matches", force: :cascade do |t|
    t.integer  "white_player_id"
    t.integer  "black_player_id"
    t.integer  "round"
    t.string   "result"
    t.integer  "tournament_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "players", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.boolean  "admin",                  default: false
  end

  add_index "players", ["email"], name: "index_players_on_email", unique: true
  add_index "players", ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true

  create_table "players_tournaments", id: false, force: :cascade do |t|
    t.integer "player_id"
    t.integer "tournament_id"
  end

  add_index "players_tournaments", ["player_id"], name: "index_players_tournaments_on_player_id"
  add_index "players_tournaments", ["tournament_id"], name: "index_players_tournaments_on_tournament_id"

  create_table "tournaments", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "start_date"
    t.string   "tournament_type"
    t.integer  "rounds"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
