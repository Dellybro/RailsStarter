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

ActiveRecord::Schema.define(version: 20160824182150) do

  create_table "pictures", force: :cascade do |t|
    t.string   "objectId",       limit: 255
    t.string   "uploader",       limit: 255
    t.string   "name",           limit: 255
    t.string   "filename",       limit: 255
    t.integer  "picture_index",  limit: 4
    t.integer  "imageable_id",   limit: 4
    t.string   "imageable_type", limit: 255
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "pictures", ["imageable_type", "imageable_id"], name: "index_pictures_on_imageable_type_and_imageable_id", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "objectId",    limit: 255
    t.boolean  "send_emails"
    t.integer  "user_id",     limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name",        limit: 255
    t.string   "last_name",         limit: 255
    t.string   "full_name",         limit: 255
    t.string   "email",             limit: 255
    t.string   "password",          limit: 255
    t.string   "password_digest",   limit: 255
    t.string   "objectId",          limit: 255
    t.string   "username",          limit: 255
    t.boolean  "activated"
    t.datetime "activated_at"
    t.datetime "last_login"
    t.datetime "reset_sent_at"
    t.string   "reset_digest",      limit: 255
    t.string   "activation_digest", limit: 255
    t.string   "remember_digest",   limit: 255
    t.string   "auth_token",        limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

end
