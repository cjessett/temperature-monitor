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

ActiveRecord::Schema.define(version: 2019_06_26_221030) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "devices", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "thing_name"
    t.index ["thing_name"], name: "index_devices_on_thing_name", unique: true
  end

  create_table "devices_and_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "device_id"
    t.index ["device_id"], name: "index_devices_and_users_on_device_id"
    t.index ["user_id"], name: "index_devices_and_users_on_user_id"
  end

  create_table "devices_users", force: :cascade do |t|
    t.integer "user_id"
    t.integer "device_id"
    t.index ["device_id"], name: "index_devices_users_on_device_id"
    t.index ["user_id"], name: "index_devices_users_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "max"
    t.integer "min"
    t.integer "device_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "arn"
    t.index ["device_id"], name: "index_notifications_on_device_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
