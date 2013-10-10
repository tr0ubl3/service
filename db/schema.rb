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

ActiveRecord::Schema.define(:version => 20131010195306) do

  create_table "alarms", :force => true do |t|
    t.integer  "number"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "events", :force => true do |t|
    t.integer  "machine_id"
    t.date     "event_date"
    t.string   "event_type"
    t.text     "event_description"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "hour_counter"
    t.string   "alarm_code"
  end

  add_index "events", ["machine_id"], :name => "index_events_on_machine_id"

  create_table "events_alarms", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "alarm_id"
  end

  add_index "events_alarms", ["event_id", "alarm_id"], :name => "index_events_alarms_on_event_id_and_alarm_id"

  create_table "firms", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "office_tel"
    t.string   "office_mail"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "country"
    t.string   "city"
    t.string   "postal_code"
    t.string   "fax"
    t.string   "mobile"
    t.string   "type"
  end

  create_table "machines", :force => true do |t|
    t.integer  "manufacturer_id"
    t.integer  "machine_owner_id"
    t.string   "machine_number"
    t.string   "machine_type"
    t.date     "delivery_date"
    t.integer  "waranty_period"
    t.string   "display_name"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  add_index "machines", ["machine_owner_id"], :name => "index_machines_on_machine_owner_id"
  add_index "machines", ["manufacturer_id"], :name => "index_machines_on_manufacturer_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "nick"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
