# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091219222525) do

  create_table "locations", :force => true do |t|
    t.integer  "woeid"
    t.string   "name"
    t.string   "country"
    t.integer  "lat"
    t.string   "lon"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "weather_readings", :force => true do |t|
    t.integer  "location_id"
    t.integer  "woeid"
    t.datetime "reading_time"
    t.integer  "temperature"
    t.integer  "weather_condition"
    t.string   "weather_condition_string"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "weather_readings", ["location_id"], :name => "index_weather_readings_on_location_id"

end
