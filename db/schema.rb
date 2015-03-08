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

ActiveRecord::Schema.define(version: 20150304042225) do

  create_table "accesses", force: :cascade do |t|
    t.string   "username",        limit: 64
    t.string   "password_digest", limit: 512
    t.boolean  "remember_me",     limit: 1,   default: false
    t.string   "security_level",  limit: 128, default: "NONE"
    t.integer  "entity_id",       limit: 4
    t.boolean  "enabled",         limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "accesses", ["username"], name: "index_accesses_on_username", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "description",       limit: 256
    t.decimal  "longitude",                     precision: 18, scale: 12
    t.decimal  "latitude",                      precision: 18, scale: 12
    t.integer  "contact_detail_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "allowable_sets", force: :cascade do |t|
    t.string   "security_level", limit: 128
    t.string   "controller",     limit: 128
    t.string   "action",         limit: 128
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "constants", force: :cascade do |t|
    t.string   "constant",    limit: 512
    t.string   "description", limit: 512
    t.string   "type",        limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_details", force: :cascade do |t|
    t.integer  "entity_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "digitals", force: :cascade do |t|
    t.string   "url",               limit: 512
    t.string   "description",       limit: 512
    t.integer  "contact_detail_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entities", force: :cascade do |t|
    t.string   "name",        limit: 128
    t.string   "description", limit: 512
    t.string   "logo",        limit: 512
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entity_connectors", force: :cascade do |t|
    t.integer  "entity_id_one",     limit: 8
    t.string   "relationship",      limit: 128
    t.string   "relationship_type", limit: 128
    t.integer  "entity_id_two",     limit: 8
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "telephones", force: :cascade do |t|
    t.string   "digits",            limit: 32
    t.string   "description",       limit: 512
    t.integer  "contact_detail_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "verifications", force: :cascade do |t|
    t.string   "temp_email", limit: 128
    t.string   "hashlink",   limit: 512
    t.boolean  "verified",   limit: 1,   default: false
    t.integer  "access_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
