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

ActiveRecord::Schema.define(version: 2019_10_15_042820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.string "area"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_messages_on_room_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "postages", force: :cascade do |t|
    t.string "item_type"
    t.string "company"
    t.integer "hokkaido"
    t.integer "touhoku"
    t.integer "kitatouhoku"
    t.integer "minamitouhoku"
    t.integer "hokuriku"
    t.integer "shinetsu"
    t.integer "kantou"
    t.integer "tokyo"
    t.integer "chubu"
    t.integer "kansai"
    t.integer "chugoku"
    t.integer "shikoku"
    t.integer "kyushu"
    t.integer "kitakyushu"
    t.integer "minamikyushu"
    t.integer "okinawa"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "area"
    t.index ["id", "item_type"], name: "index_postages_on_id_and_item_type", unique: true
    t.index ["user_id"], name: "index_postages_on_user_id"
  end

  create_table "product_items", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_product_items_on_product_id"
    t.index ["user_id", "product_id"], name: "index_product_items_on_user_id_and_product_id", unique: true
    t.index ["user_id"], name: "index_product_items_on_user_id"
  end

  create_table "room_managers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "room_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "accessed_at"
    t.index ["room_id"], name: "index_room_managers_on_room_id"
    t.index ["user_id"], name: "index_room_managers_on_user_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer "order_product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "posted_at"
    t.index ["order_product_id"], name: "index_rooms_on_order_product_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.integer "quantity"
    t.integer "shipment_week"
    t.text "remark"
    t.datetime "salable"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "accept_order_count", default: 0
    t.string "pref"
    t.string "area"
    t.bigint "product_id"
    t.index ["product_id"], name: "index_stocks_on_product_id"
    t.index ["user_id", "product_id", "shipment_week"], name: "index_stocks_on_user_id_and_product_id_and_shipment_week", unique: true
    t.index ["user_id"], name: "index_stocks_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "corporate_name"
    t.string "lastname"
    t.string "firstname"
    t.string "lastname_phonetic"
    t.string "firstname_phonetic"
    t.string "email"
    t.string "phone"
    t.string "zipcode"
    t.string "pref"
    t.string "area"
    t.string "city"
    t.string "street"
    t.string "building"
    t.string "password_digest"
    t.string "remember_digest"
    t.string "activation_digest"
    t.datetime "activated_at"
    t.boolean "activated", default: false
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.boolean "admin", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["area"], name: "index_users_on_area"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["pref"], name: "index_users_on_pref"
  end

  add_foreign_key "messages", "rooms"
  add_foreign_key "messages", "users"
  add_foreign_key "postages", "users"
  add_foreign_key "product_items", "users"
  add_foreign_key "room_managers", "rooms"
  add_foreign_key "room_managers", "users"
  add_foreign_key "stocks", "users"
end
