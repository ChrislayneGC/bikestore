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

ActiveRecord::Schema.define(version: 20181209030015) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "agency"
    t.string   "account"
    t.string   "bank"
    t.string   "name"
    t.string   "identifier"
    t.boolean  "active"
    t.string   "code"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounts", ["slug"], name: "index_accounts_on_slug", using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "kind",       default: "home"
    t.string   "street"
    t.string   "district"
    t.string   "number"
    t.string   "zipcode"
    t.string   "city"
    t.string   "state"
    t.string   "country",    default: "Brasil"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "active"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "complement"
  end

  add_index "addresses", ["user_id"], name: "index_addresses_on_user_id", using: :btree

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "app_infos", force: :cascade do |t|
    t.string   "bio_title"
    t.string   "bio"
    t.string   "email"
    t.string   "facebook"
    t.string   "instagram"
    t.string   "whatsapp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "banners", force: :cascade do |t|
    t.boolean  "active"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "name"
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "cart_id"
    t.integer  "item_id"
    t.integer  "quantity",                            default: 0
    t.decimal  "price",      precision: 14, scale: 2, default: 0.0
    t.decimal  "total",      precision: 14, scale: 2, default: 0.0
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "cart_items", ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
  add_index "cart_items", ["item_id"], name: "index_cart_items_on_item_id", using: :btree

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "items_count", default: 0
    t.decimal  "total",       default: 0.0
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.string   "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "categories", ["slug"], name: "index_categories_on_slug", using: :btree

  create_table "item_images", force: :cascade do |t|
    t.string   "name"
    t.integer  "item_id"
    t.string   "slug"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  add_index "item_images", ["item_id"], name: "index_item_images_on_item_id", using: :btree
  add_index "item_images", ["slug"], name: "index_item_images_on_slug", using: :btree

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.decimal  "weight"
    t.decimal  "height"
    t.decimal  "length"
    t.decimal  "width"
    t.boolean  "active"
    t.string   "description"
    t.integer  "subcategory_id"
    t.string   "slug"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "code"
    t.text     "text"
    t.boolean  "highlight",          default: false
    t.integer  "quantity",           default: 1
  end

  add_index "items", ["slug"], name: "index_items_on_slug", using: :btree
  add_index "items", ["subcategory_id"], name: "index_items_on_subcategory_id", using: :btree

  create_table "order_items", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "item_id"
    t.integer  "quantity",                            default: 0
    t.decimal  "price",      precision: 14, scale: 2, default: 0.0
    t.decimal  "total",      precision: 14, scale: 2, default: 0.0
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  add_index "order_items", ["item_id"], name: "index_order_items_on_item_id", using: :btree
  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree

  create_table "order_shippings", force: :cascade do |t|
    t.integer  "order_id"
    t.string   "kind"
    t.string   "street"
    t.string   "district"
    t.string   "number"
    t.string   "zipcode"
    t.string   "city"
    t.string   "state"
    t.string   "country",    default: "Brasil"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "value"
    t.string   "status"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "complement"
  end

  add_index "order_shippings", ["order_id"], name: "index_order_shippings_on_order_id", using: :btree
  add_index "order_shippings", ["status"], name: "index_order_shippings_on_status", using: :btree

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "number"
    t.string   "payment_method"
    t.text     "payment_data"
    t.integer  "payment_months"
    t.string   "payment_status",                              default: "waiting"
    t.string   "payment_invoice_id"
    t.datetime "delivered_in"
    t.decimal  "total",              precision: 14, scale: 2, default: 0.0
    t.string   "slug"
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.string   "billet_url"
    t.string   "delivery_code"
  end

  add_index "orders", ["number"], name: "index_orders_on_number", using: :btree
  add_index "orders", ["payment_invoice_id"], name: "index_orders_on_payment_invoice_id", using: :btree
  add_index "orders", ["slug"], name: "index_orders_on_slug", using: :btree
  add_index "orders", ["user_id"], name: "index_orders_on_user_id", using: :btree

  create_table "subcategories", force: :cascade do |t|
    t.string   "name"
    t.boolean  "active"
    t.integer  "category_id"
    t.string   "slug"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "subcategories", ["category_id"], name: "index_subcategories_on_category_id", using: :btree
  add_index "subcategories", ["slug"], name: "index_subcategories_on_slug", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.string   "identifier"
    t.datetime "birthday"
    t.string   "phone"
    t.string   "slug"
    t.boolean  "active"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "accounts", "users"
  add_foreign_key "addresses", "users"
end
