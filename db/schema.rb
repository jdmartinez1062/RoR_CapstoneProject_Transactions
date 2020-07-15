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

ActiveRecord::Schema.define(version: 2020_07_14_185946) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "groups", force: :cascade do |t|
    t.string "name"
    t.integer "selected_id"
    t.string "icon"
    t.datetime "created_at", null: false
    t.index ["selected_id"], name: "index_groups_on_selected_id"
  end

  create_table "groups_times", id: false, force: :cascade do |t|
    t.integer "group_id"
    t.integer "time_log_id"
  end

  create_table "time_spents", force: :cascade do |t|
    t.integer "author_id"
    t.string "name"
    t.float "amount"
    t.datetime "created_at", null: false
    t.index ["author_id", "created_at"], name: "index_time_spents_on_author_id_and_created_at"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.index ["name"], name: "index_users_on_name", unique: true
  end

end
