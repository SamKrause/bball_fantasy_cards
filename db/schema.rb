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

ActiveRecord::Schema.define(version: 20160420170047) do

  create_table "computer_day_points", force: :cascade do |t|
    t.integer  "computer_team_id"
    t.float    "fantasy_points"
    t.datetime "date"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "computer_teams", force: :cascade do |t|
    t.string   "team_name"
    t.string   "gameday_id"
    t.string   "team_city"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

  create_table "day_stats", force: :cascade do |t|
    t.datetime "date"
    t.integer  "ab"
    t.integer  "h"
    t.integer  "bb"
    t.integer  "so"
    t.integer  "r"
    t.integer  "sb"
    t.integer  "hr"
    t.integer  "rbi"
    t.integer  "single"
    t.integer  "double"
    t.integer  "triple"
    t.integer  "playercard_id"
    t.float    "fantasy_points"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "hbp"
  end

  create_table "games", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "computer_day_point_id"
    t.datetime "date"
    t.boolean  "user_win"
    t.integer  "user_points"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "playercard_games", force: :cascade do |t|
    t.integer  "playercard_id"
    t.integer  "game_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "playercards", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "pro_team_name"
    t.string   "pro_team_city"
    t.string   "position"
    t.integer  "number"
    t.integer  "gameday_id"
    t.integer  "cbs_id"
    t.integer  "rank"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "picture_file_name"
    t.string   "picture_content_type"
    t.integer  "picture_file_size"
    t.datetime "picture_updated_at"
  end

  create_table "season_stats", force: :cascade do |t|
    t.float    "avg"
    t.integer  "ab"
    t.integer  "h"
    t.integer  "bb"
    t.integer  "so"
    t.integer  "r"
    t.integer  "sb"
    t.integer  "hr"
    t.integer  "rbi"
    t.integer  "year"
    t.integer  "playercard_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "user_playercards", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "playercard_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "team_name"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
