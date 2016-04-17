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

ActiveRecord::Schema.define(version: 20160419165138) do

  create_table "comments", force: :cascade do |t|
    t.string   "content",      limit: 255
    t.datetime "start_time"
    t.float    "rating_point", limit: 24
    t.integer  "user_id",      limit: 4
    t.integer  "review_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "comments", ["review_id"], name: "index_comments_on_review_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "coordinates", force: :cascade do |t|
    t.float    "lat",        limit: 24
    t.float    "lng",        limit: 24
    t.integer  "region_id",  limit: 4
    t.integer  "store_id",   limit: 4
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  add_index "coordinates", ["region_id"], name: "index_coordinates_on_region_id", using: :btree
  add_index "coordinates", ["store_id"], name: "index_coordinates_on_store_id", using: :btree

  create_table "images", force: :cascade do |t|
    t.string   "image",      limit: 255
    t.string   "caption",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "store_id",   limit: 4
  end

  create_table "marks", force: :cascade do |t|
    t.datetime "start_time"
    t.integer  "user_id",    limit: 4
    t.integer  "review_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "marks", ["review_id"], name: "index_marks_on_review_id", using: :btree
  add_index "marks", ["user_id"], name: "index_marks_on_user_id", using: :btree

  create_table "products", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.integer  "price",      limit: 4
    t.integer  "store_id",   limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "products", ["store_id"], name: "index_products_on_store_id", using: :btree

  create_table "regions", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.text     "content",        limit: 65535
    t.float    "average_rating", limit: 24
    t.float    "total_rating",   limit: 24
    t.integer  "user_id",        limit: 4
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "reviews", ["user_id"], name: "index_reviews_on_user_id", using: :btree

  create_table "stores", force: :cascade do |t|
    t.string   "name",         limit: 255
    t.string   "address",      limit: 255
    t.string   "phone_number", limit: 255
    t.string   "owner",        limit: 255
    t.integer  "review_id",    limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "stores", ["review_id"], name: "index_stores_on_review_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   limit: 255
    t.string   "password",               limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "comments", "reviews"
  add_foreign_key "comments", "users"
  add_foreign_key "coordinates", "regions"
  add_foreign_key "coordinates", "stores"
  add_foreign_key "marks", "reviews"
  add_foreign_key "marks", "users"
  add_foreign_key "products", "stores"
  add_foreign_key "reviews", "users"
  add_foreign_key "stores", "reviews"
end
