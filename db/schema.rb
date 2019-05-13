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

ActiveRecord::Schema.define(version: 2019_05_13_151941) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "banners", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "name"
  end

  create_table "categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "checkouts", id: :serial, force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "billing_address"
    t.string "billing_suburb"
    t.integer "billing_zip"
    t.string "billing_state"
    t.string "phone"
    t.decimal "total", precision: 8, scale: 2
    t.integer "user_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email"
    t.string "shipping_address"
    t.string "shipping_suburb"
    t.integer "shipping_zip"
    t.string "shipping_state"
    t.string "slug", null: false
    t.string "status"
    t.string "credit_card_number"
    t.string "credit_card_name"
    t.string "credit_card_expire_date"
    t.string "credit_card_ccv"
    t.string "coupom_code"
    t.index ["slug"], name: "index_checkouts_on_slug", unique: true
  end

  create_table "coupoms", force: :cascade do |t|
    t.bigint "user_id"
    t.string "code"
    t.decimal "value"
    t.boolean "used"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_coupoms_on_user_id"
  end

  create_table "feature_toggles", force: :cascade do |t|
    t.string "name"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.bigint "stock_id"
    t.bigint "product_id"
    t.boolean "sold"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_items_on_product_id"
    t.index ["stock_id"], name: "index_items_on_stock_id"
  end

  create_table "order_items", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.integer "order_id"
    t.decimal "unit_price", precision: 12, scale: 3
    t.integer "quantity"
    t.decimal "total_price", precision: 12, scale: 3
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_order_items_on_order_id"
  end

  create_table "order_statuses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", id: :serial, force: :cascade do |t|
    t.decimal "tax"
    t.decimal "gst"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "order_status_id"
    t.decimal "subtotal", precision: 8, scale: 2
    t.string "coupom_code"
    t.bigint "checkout_id"
    t.index ["checkout_id"], name: "index_orders_on_checkout_id"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
  end

  create_table "pages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.string "slug", null: false
    t.boolean "contact_form"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.boolean "published"
    t.integer "position"
    t.index ["slug"], name: "index_pages_on_slug", unique: true
  end

  create_table "pictures", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "imageable_type"
    t.integer "imageable_id"
    t.index ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id"
  end

  create_table "products", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.decimal "price", precision: 8, scale: 2
    t.decimal "old_price"
    t.boolean "on_sale"
    t.boolean "sold_out"
    t.boolean "featured"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "category_id"
    t.integer "user_id"
    t.string "author"
    t.string "year"
    t.string "title"
    t.string "publisher"
    t.string "edition"
    t.string "isbn"
    t.string "pages"
    t.string "synopsis"
    t.string "dimensions"
    t.string "barcode"
    t.boolean "active"
    t.string "activation_reason"
  end

  create_table "returns", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "item_id"
    t.string "return_reason"
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "quantity"
    t.index ["item_id"], name: "index_returns_on_item_id"
    t.index ["user_id"], name: "index_returns_on_user_id"
  end

  create_table "stocks", force: :cascade do |t|
    t.bigint "product_id"
    t.integer "quantity"
    t.decimal "price"
    t.string "lot"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_id"], name: "index_stocks_on_product_id"
  end

  create_table "uploads", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "billing_address"
    t.string "billing_suburb"
    t.integer "billing_zip"
    t.string "billing_state"
    t.string "phone"
    t.boolean "admin"
    t.string "image_file_name"
    t.string "image_content_type"
    t.integer "image_file_size"
    t.datetime "image_updated_at"
    t.string "shipping_address"
    t.string "shipping_suburb"
    t.integer "shipping_zip"
    t.string "shipping_state"
    t.string "provider"
    t.string "uid"
    t.string "credit_card_number"
    t.string "credit_card_name"
    t.string "credit_card_expire_date"
    t.string "credit_card_ccv"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "items", "products"
  add_foreign_key "items", "stocks"
  add_foreign_key "order_items", "items"
  add_foreign_key "order_items", "orders"
  add_foreign_key "orders", "checkouts"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "returns", "items"
  add_foreign_key "returns", "users"
  add_foreign_key "stocks", "products"
end
