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

ActiveRecord::Schema.define(version: 2019_04_25_142654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "activities", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "activity_category_id"
    t.string "name"
    t.text "description"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "activity_date"
    t.index ["activity_category_id"], name: "index_activities_on_activity_category_id"
    t.index ["user_id"], name: "index_activities_on_user_id"
  end

  create_table "activity_categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "owner_value"
    t.integer "member_value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.string "social_reason"
    t.string "client_email"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "cores", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "initial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "deals", force: :cascade do |t|
    t.datetime "deal_date"
    t.string "client_name"
    t.string "client_company"
    t.string "sector"
    t.text "sector_description"
    t.text "problems"
    t.text "address"
    t.string "website"
    t.string "telephone1"
    t.string "telephone2"
    t.string "email"
    t.text "info"
    t.string "arrival"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.decimal "price"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_deals_on_user_id"
  end

  create_table "did_goods", force: :cascade do |t|
    t.integer "sender_id", null: false
    t.integer "receiver_id", null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "signature", default: "Mandou Bem!"
    t.string "photourl", default: "https://cdn.diariodolitoral.com.br/upload/dn_noticia/2019/01/bolsonaro-fp134.jpg"
    t.boolean "is_superdidgood", default: false
  end

  create_table "documents", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "extracts", force: :cascade do |t|
    t.bigint "user_id"
    t.integer "kind"
    t.text "description"
    t.decimal "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_extracts_on_user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.float "value"
    t.integer "kind"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hours", force: :cascade do |t|
    t.integer "weekly_hours", default: 12
    t.integer "max_hours", default: 15
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "value"
    t.integer "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "available", default: true
  end

  create_table "notifications", force: :cascade do |t|
    t.string "title"
    t.text "message"
    t.integer "kind"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "occupations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_admin", default: false
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "item_id"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["item_id"], name: "index_orders_on_item_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "project_id"
    t.float "value"
    t.date "payment_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status", default: 0
    t.index ["project_id"], name: "index_payments_on_project_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.date "enddate"
    t.bigint "client_id"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "nps"
    t.integer "nps2"
    t.date "start_date"
    t.index ["client_id"], name: "index_projects_on_client_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repays", force: :cascade do |t|
    t.bigint "user_id"
    t.text "description"
    t.float "value"
    t.integer "kind", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.date "payment_date"
    t.index ["user_id"], name: "index_repays_on_user_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "setups", force: :cascade do |t|
    t.integer "weekly_hours"
    t.integer "superdidgood_price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "devs_percentage", default: 15
    t.integer "negs_percentage", default: 8
  end

  create_table "user_activities", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["activity_id"], name: "index_user_activities_on_activity_id"
    t.index ["user_id"], name: "index_user_activities_on_user_id"
  end

  create_table "user_core_occupations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "core_id"
    t.bigint "occupation_id"
    t.date "enterdate"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["core_id"], name: "index_user_core_occupations_on_core_id"
    t.index ["occupation_id"], name: "index_user_core_occupations_on_occupation_id"
    t.index ["user_id"], name: "index_user_core_occupations_on_user_id"
  end

  create_table "user_projects", force: :cascade do |t|
    t.bigint "project_id"
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["project_id"], name: "index_user_projects_on_project_id"
    t.index ["role_id"], name: "index_user_projects_on_role_id"
    t.index ["user_id"], name: "index_user_projects_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.date "birthdate"
    t.date "enterdate"
    t.string "git_url"
    t.string "phone"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "clockify_user_id"
    t.string "clockify_active_workspace_id"
    t.string "clockify_refresh_token"
    t.string "clockify_key"
    t.string "access_token"
    t.integer "did_goods_sent", default: 0, null: false
    t.integer "did_goods_received", default: 0, null: false
    t.boolean "sawdidgood", default: false
    t.integer "coins", default: 50
    t.boolean "sawnotifications", default: false
    t.string "total_lifetime"
    t.string "username"
    t.decimal "beneficial_politics", default: "0.0"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "activities", "activity_categories"
  add_foreign_key "activities", "users"
  add_foreign_key "deals", "users"
  add_foreign_key "extracts", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "orders", "items"
  add_foreign_key "orders", "users"
  add_foreign_key "payments", "projects"
  add_foreign_key "projects", "clients"
  add_foreign_key "repays", "users"
  add_foreign_key "user_activities", "activities"
  add_foreign_key "user_activities", "users"
  add_foreign_key "user_core_occupations", "cores"
  add_foreign_key "user_core_occupations", "occupations"
  add_foreign_key "user_core_occupations", "users"
  add_foreign_key "user_projects", "projects"
  add_foreign_key "user_projects", "roles"
  add_foreign_key "user_projects", "users"
end
