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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130602113506) do

  create_table "admins", :force => true do |t|
    t.string   "email",                  :default => "",    :null => false
    t.string   "encrypted_password",     :default => "",    :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "name",                                      :null => false
    t.boolean  "superadmin",             :default => false
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
  end

  add_index "admins", ["email"], :name => "index_admins_on_email", :unique => true
  add_index "admins", ["reset_password_token"], :name => "index_admins_on_reset_password_token", :unique => true

  create_table "events", :force => true do |t|
    t.string   "key",        :limit => 40,                     :null => false
    t.string   "name",                                         :null => false
    t.boolean  "card_uid",                 :default => true
    t.boolean  "resource",                 :default => true
    t.string   "url",                                          :null => false
    t.string   "method",     :limit => 10, :default => "post", :null => false
    t.string   "format",     :limit => 10, :default => "json", :null => false
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "admin_id",                                     :null => false
  end

  add_index "events", ["admin_id"], :name => "index_events_on_admin_id"
  add_index "events", ["key"], :name => "index_events_on_key", :unique => true

  create_table "squid_cards", :force => true do |t|
    t.string   "uid",        :limit => 40, :null => false
    t.string   "reference"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "squid_cards", ["reference"], :name => "index_squid_cards_on_reference"
  add_index "squid_cards", ["uid"], :name => "index_squid_cards_on_uid", :unique => true

end
