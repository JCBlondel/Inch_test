# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_07_18_000626) do

  create_table "buildings", force: :cascade do |t|
    t.string "reference"
    t.string "address"
    t.string "zip_code"
    t.string "city"
    t.string "country"
    t.string "manager_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reference"], name: "index_buildings_on_reference", unique: true
  end

  create_table "people", force: :cascade do |t|
    t.string "reference"
    t.string "email"
    t.string "home_phone_number"
    t.string "mobile_phone_number"
    t.string "firstname"
    t.string "lastname"
    t.string "address"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reference"], name: "index_people_on_reference", unique: true
  end

end
