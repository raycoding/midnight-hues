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

ActiveRecord::Schema.define(version: 20151006090428) do

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   limit: 4,     default: 0, null: false
    t.integer  "attempts",   limit: 4,     default: 0, null: false
    t.text     "handler",    limit: 65535,             null: false
    t.text     "last_error", limit: 65535
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",  limit: 255
    t.string   "queue",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree
  add_index "delayed_jobs", ["queue", "priority", "run_at"], name: "delayed_jobs_priority_by_queue", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "type",            limit: 255
    t.string   "zip",             limit: 10
    t.string   "city",            limit: 200
    t.string   "district",        limit: 100
    t.string   "state",           limit: 100
    t.string   "country",         limit: 50
    t.string   "status",          limit: 255, default: "active"
    t.string   "phone_code",      limit: 255
    t.string   "iso2code",        limit: 255
    t.string   "iso3code",        limit: 255
    t.string   "created_by",      limit: 255
    t.string   "last_updated_by", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at",                                     null: false
  end

  add_index "locations", ["city"], name: "index_city", using: :btree
  add_index "locations", ["country", "state", "city", "zip"], name: "c_st_ci_zip", using: :btree
  add_index "locations", ["country", "state", "district", "city", "zip"], name: "c_st_dis_ci_zip", using: :btree
  add_index "locations", ["country"], name: "index_country", using: :btree
  add_index "locations", ["state"], name: "index_state", using: :btree
  add_index "locations", ["type"], name: "index_type", using: :btree
  add_index "locations", ["zip"], name: "index_zip", using: :btree

  create_table "roles", force: :cascade do |t|
    t.string   "name",        limit: 255,                      null: false
    t.text     "permissions", limit: 65535
    t.string   "status",      limit: 255,   default: "active"
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", unique: true, using: :btree

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", limit: 255,   null: false
    t.text     "data",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "temp_locations", id: false, force: :cascade do |t|
    t.string  "c_code",      limit: 2
    t.string  "zip",         limit: 20
    t.string  "area",        limit: 180
    t.string  "state",       limit: 100
    t.string  "district",    limit: 200
    t.string  "admin_name3", limit: 100
    t.string  "latitude",    limit: 20
    t.string  "longitude",   limit: 20
    t.integer "accuracy",    limit: 4
  end

  create_table "tmp_locations", id: false, force: :cascade do |t|
    t.string "type",       limit: 255
    t.string "zip",        limit: 20
    t.string "city",       limit: 255
    t.string "district",   limit: 255
    t.string "state",      limit: 255
    t.string "country",    limit: 255
    t.string "status",     limit: 255
    t.string "phone_code", limit: 255
    t.string "iso2code",   limit: 255
    t.string "iso3code",   limit: 255
  end

  create_table "user_roles", force: :cascade do |t|
    t.integer  "user_id",      limit: 4,                      null: false
    t.integer  "role_id",      limit: 4,                      null: false
    t.integer  "grant_option", limit: 1,   default: 0,        null: false
    t.string   "status",       limit: 255, default: "active"
    t.string   "created_by",   limit: 255, default: "self"
    t.string   "updated_by",   limit: 255, default: "self"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_roles", ["user_id", "role_id"], name: "index_user_roles_on_user_id_and_role_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                limit: 255
    t.string   "email",               limit: 255
    t.string   "primary_phone",       limit: 255
    t.string   "status",              limit: 255, default: "active"
    t.integer  "manager_id",          limit: 4
    t.string   "password",            limit: 255
    t.string   "crypted_password",    limit: 255
    t.string   "password_salt",       limit: 255
    t.string   "persistence_token",   limit: 255
    t.string   "single_access_token", limit: 255
    t.string   "perishable_token",    limit: 255
    t.integer  "login_count",         limit: 4,   default: 0
    t.integer  "failed_login_count",  limit: 4,   default: 0
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",    limit: 255
    t.string   "last_login_ip",       limit: 255
    t.string   "login_token",         limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["primary_phone"], name: "index_users_on_primary_phone", unique: true, using: :btree

end
