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

ActiveRecord::Schema.define(version: 20170921062852) do

  create_table "cases", force: true do |t|
    t.integer  "remote_id"
    t.datetime "opened_at"
    t.datetime "closed_at"
    t.datetime "remote_updated_at"
    t.string   "status"
    t.text     "status_note"
    t.string   "responsible_agency"
    t.string   "service"
    t.string   "service_subtype"
    t.string   "service_details"
    t.string   "address"
    t.integer  "supervisor_district_id"
    t.string   "neighborhood"
    t.string   "police_district"
    t.string   "source"
    t.string   "media_url"
    t.decimal  "lat",                    precision: 8, scale: 5
    t.decimal  "lng",                    precision: 8, scale: 5
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cases", ["opened_at"], name: "index_cases_on_opened_at", using: :btree

end
