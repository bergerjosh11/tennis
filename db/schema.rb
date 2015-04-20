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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110216132323) do

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",       :default => "",    :null => false
    t.string   "last_name",        :default => "",    :null => false
    t.string   "role",                                :null => false
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token",                               :null => false
    t.string   "salt",                                :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admin_users", ["email"], :name => "index_admin_users_on_email", :unique => true

  create_table "match_requests", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "second_player_id"
    t.boolean  "cancelled",        :default => false
    t.boolean  "denied",           :default => false
    t.boolean  "accepted",         :default => false
    t.integer  "match_id"
    t.text     "why_denied"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.integer  "owner_id"
    t.integer  "first_player_id"
    t.integer  "second_player_id"
    t.integer  "winner_id"
    t.boolean  "was_played",                 :default => false
    t.boolean  "info_provided",              :default => false
    t.boolean  "info_denied",                :default => false
    t.text     "why_denied"
    t.date     "when"
    t.string   "where"
    t.string   "score"
    t.text     "first_players_description"
    t.text     "second_players_description"
    t.boolean  "first_player_ignores",       :default => false
    t.boolean  "second_player_ignores",      :default => false
    t.boolean  "tournament_match",           :default => false
    t.string   "tournament_phase"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_rated_by_first_player",   :default => false
    t.boolean  "is_rated_by_second_player",  :default => false
    t.boolean  "cancelled",                  :default => false
  end

  create_table "messages", :force => true do |t|
    t.text     "content"
    t.boolean  "read",             :default => false
    t.integer  "author_id"
    t.integer  "addressee_id"
    t.integer  "match_id"
    t.integer  "match_request_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.string   "nick"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.decimal  "ntrp"
    t.string   "email"
    t.boolean  "active",     :default => true
    t.boolean  "hide_name",  :default => false
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rates", :force => true do |t|
    t.integer  "rate_value"
    t.text     "description"
    t.integer  "who_gave_id"
    t.integer  "owner_id"
    t.integer  "match_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                              :default => "", :null => false
    t.string   "encrypted_password",  :limit => 128, :default => "", :null => false
    t.string   "password_salt",                      :default => "", :null => false
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true

end
