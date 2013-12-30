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

ActiveRecord::Schema.define(version: 20131230150149) do

  create_table "tickets", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
    t.string   "status"
    t.string   "priority"
    t.string   "category"
    t.string   "private"
    t.decimal  "lat",                            precision: 10, scale: 7
    t.decimal  "lon",                            precision: 10, scale: 7
    t.text     "image",       limit: 2147483647
    t.string   "address"
  end

end
