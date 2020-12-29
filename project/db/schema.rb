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

ActiveRecord::Schema.define(version: 2020_11_28_120914) do

  create_table "cartitems", force: :cascade do |t|
    t.integer "quantity"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "product_id"
    t.index ["product_id"], name: "index_cartitems_on_product_id"
    t.index ["user_id"], name: "index_cartitems_on_user_id"
  end

  create_table "colors", force: :cascade do |t|
    t.text "rgb"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "product_id"
    t.index ["product_id"], name: "index_favorites_on_product_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "order_products", force: :cascade do |t|
    t.integer "product_id"
    t.integer "transaction_order_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "quantity", default: 1
  end

  create_table "pictures", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "product_types", force: :cascade do |t|
    t.text "product_type_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "products", force: :cascade do |t|
    t.text "name"
    t.decimal "price"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "color_id"
    t.integer "product_type_id"
    t.text "detail"
    t.string "pics"
    t.text "size"
    t.text "material"
    t.index ["color_id"], name: "index_products_on_color_id"
  end

  create_table "sizes", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transaction_items", force: :cascade do |t|
    t.integer "quantity"
    t.decimal "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "product_id"
    t.integer "transaction_order_id"
    t.index ["product_id"], name: "index_transaction_items_on_product_id"
    t.index ["transaction_order_id"], name: "index_transaction_items_on_transaction_order_id"
    t.index ["user_id"], name: "index_transaction_items_on_user_id"
  end

  create_table "transaction_orders", force: :cascade do |t|
    t.decimal "sum"
    t.text "address"
    t.text "name"
    t.text "phone"
    t.text "postcode"
    t.integer "sstatus", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.text "email"
    t.text "note"
    t.index ["user_id"], name: "index_transaction_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "name"
    t.boolean "isadmin", default: false
    t.text "phone"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.text "address"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "cartitems", "products"
  add_foreign_key "cartitems", "users"
  add_foreign_key "favorites", "products"
  add_foreign_key "favorites", "users"
  add_foreign_key "products", "colors"
  add_foreign_key "transaction_items", "products"
  add_foreign_key "transaction_items", "transaction_orders"
  add_foreign_key "transaction_items", "users"
  add_foreign_key "transaction_orders", "users"
end
