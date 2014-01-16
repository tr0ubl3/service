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

ActiveRecord::Schema.define(:version => 20140116105540) do

  create_table "alarms", :force => true do |t|
    t.integer  "number"
    t.text     "text"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "alarms_service_events", :id => false, :force => true do |t|
    t.integer "service_event_id"
    t.integer "alarm_id"
  end

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

  create_table "hour_counters", :force => true do |t|
    t.integer  "machine_id"
    t.integer  "machine_hours_age"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
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

  create_table "service_event_state_transitions", :force => true do |t|
    t.integer  "service_event_id"
    t.string   "event"
    t.string   "from"
    t.string   "to"
    t.datetime "created_at"
  end

  create_table "service_events", :force => true do |t|
    t.integer  "machine_id"
    t.date     "event_date"
    t.string   "event_type"
    t.text     "event_description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "hour_counter"
    t.string   "event_name"
    t.integer  "user_id"
    t.string   "state"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email",            :default => "",    :null => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.integer  "machine_owner_id"
    t.integer  "phone_number"
    t.boolean  "admin",            :default => false
  end

  add_index "users", ["machine_owner_id"], :name => "index_users_on_machine_owner_id"

end
