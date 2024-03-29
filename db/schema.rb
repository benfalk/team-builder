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

ActiveRecord::Schema.define(version: 20140626181808) do

  create_table "champion_preferences", force: true do |t|
    t.integer  "user_id"
    t.integer  "champion_id"
    t.string   "preference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "played_count", default: 0
  end

  create_table "champions", force: true do |t|
    t.string   "name"
    t.string   "title"
    t.integer  "riot_id"
    t.string   "key"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "endorsements", force: true do |t|
    t.integer  "user_id"
    t.integer  "skill_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "endorsements", ["skill_id", "user_id"], name: "endorsements_user_skill"

  create_table "game_stats", force: true do |t|
    t.integer  "summoner_id"
    t.integer  "riot_game_uid"
    t.text     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "played_champion_id"
    t.integer  "game_id"
    t.datetime "played_at"
    t.string   "game_mode"
    t.string   "game_type"
    t.string   "sub_type"
    t.integer  "map_id"
    t.integer  "gold_per_minute",    default: 0
  end

  add_index "game_stats", ["sub_type"], name: "index_game_stats_on_sub_type"

  create_table "games", force: true do |t|
    t.integer  "riot_id"
    t.string   "game_mode"
    t.string   "game_stype"
    t.string   "sub_type"
    t.datetime "played_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "harvested",  default: false
  end

  create_table "games_summoners", id: false, force: true do |t|
    t.integer "summoner_id"
    t.integer "game_id"
  end

  add_index "games_summoners", ["summoner_id", "game_id"], name: "index_games_summoners_on_summoner_id_and_game_id", unique: true

  create_table "impressions", force: true do |t|
    t.string   "impressionable_type"
    t.integer  "impressionable_id"
    t.integer  "user_id"
    t.string   "controller_name"
    t.string   "action_name"
    t.string   "view_name"
    t.string   "request_hash"
    t.string   "ip_address"
    t.string   "session_hash"
    t.text     "message"
    t.text     "referrer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "impressions", ["controller_name", "action_name", "ip_address"], name: "controlleraction_ip_index"
  add_index "impressions", ["controller_name", "action_name", "request_hash"], name: "controlleraction_request_index"
  add_index "impressions", ["controller_name", "action_name", "session_hash"], name: "controlleraction_session_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "ip_address"], name: "poly_ip_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "request_hash"], name: "poly_request_index"
  add_index "impressions", ["impressionable_type", "impressionable_id", "session_hash"], name: "poly_session_index"
  add_index "impressions", ["impressionable_type", "message", "impressionable_id"], name: "impressionable_type_message_index"
  add_index "impressions", ["user_id"], name: "index_impressions_on_user_id"

  create_table "notifications", force: true do |t|
    t.text     "message"
    t.string   "notification_type"
    t.integer  "source_id"
    t.string   "source_type"
    t.integer  "stream_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "from",              default: ""
  end

  create_table "role_preferences", force: true do |t|
    t.integer  "user_id"
    t.integer  "role_id"
    t.string   "preference"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "map"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", force: true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["user_id"], name: "index_skills_on_user_id"

  create_table "streams", force: true do |t|
    t.integer  "owner_id"
    t.string   "owner_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "summoner_spells", force: true do |t|
    t.integer  "riot_id"
    t.string   "key"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "summoner_stats_summaries", force: true do |t|
    t.integer  "summoner_id"
    t.text     "raw"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "summoners", force: true do |t|
    t.string   "region"
    t.string   "name"
    t.integer  "level"
    t.boolean  "verified",      default: false
    t.string   "verify_string"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "riot_uid"
    t.integer  "agpm",          default: 0
    t.string   "url"
  end

  add_index "summoners", ["region", "name"], name: "index_summoners_on_region_and_name", unique: true
  add_index "summoners", ["url"], name: "index_summoners_on_url", unique: true

  create_table "team_memberships", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.integer  "role_id"
    t.string   "membership_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "summoner_id"
  end

  create_table "team_notes", force: true do |t|
    t.text     "note"
    t.string   "league_replay"
    t.integer  "team_id"
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_requests", force: true do |t|
    t.integer  "team_id"
    t.integer  "user_id"
    t.text     "message"
    t.integer  "status",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "team_summoner_invites", force: true do |t|
    t.integer  "team_id"
    t.integer  "summoner_id"
    t.integer  "status",      default: 0
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name"
    t.text     "about_us"
    t.string   "avatar"
    t.string   "play_style"
    t.string   "region"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gaming_times"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "summoner_id"
    t.string   "first_name"
    t.string   "last_name"
    t.text     "short_bio"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "play_style"
    t.string   "gaming_times"
    t.string   "avatar"
    t.string   "skype"
    t.string   "twitch_name"
    t.integer  "gender",                 default: 0
    t.string   "facebook_id"
    t.date     "birthday"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
