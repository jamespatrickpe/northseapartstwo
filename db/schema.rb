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

ActiveRecord::Schema.define(version: 20150510060018) do

  create_table "accesses", force: :cascade do |t|
    t.integer  "entity_id",       limit: 4
    t.string   "username",        limit: 64
    t.string   "password_digest", limit: 512
    t.boolean  "remember_me",     limit: 1,   default: false
    t.boolean  "enabled",         limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", force: :cascade do |t|
    t.integer  "contact_detail_id", limit: 4
    t.string   "description",       limit: 256
    t.decimal  "longitude",                     precision: 18, scale: 12
    t.decimal  "latitude",                      precision: 18, scale: 12
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "allowable_sets", force: :cascade do |t|
    t.integer  "access_id",      limit: 4
    t.string   "security_level", limit: 64
    t.string   "controller",     limit: 64
    t.string   "action",         limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", force: :cascade do |t|
    t.integer  "employee_id",     limit: 4
    t.integer  "branch_id",       limit: 4
    t.string   "department",      limit: 64
    t.string   "position",        limit: 64
    t.string   "task",            limit: 64
    t.datetime "duration_start"
    t.datetime "duration_finish"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "attendances", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.date     "day"
    t.time     "timein"
    t.time     "timeout"
    t.string   "description", limit: 128
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "base_rates", force: :cascade do |t|
    t.integer  "employee_id",    limit: 4
    t.decimal  "amount",                    precision: 32, scale: 2
    t.string   "period_of_time", limit: 32
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
  end

  create_table "biodata", force: :cascade do |t|
    t.integer  "entity_id",               limit: 4
    t.string   "education",               limit: 256
    t.string   "career_experience",       limit: 256
    t.string   "notable_accomplishments", limit: 256
    t.date     "date_of_birth"
    t.string   "family_members",          limit: 256
    t.string   "citizenship",             limit: 256
    t.string   "gender",                  limit: 256
    t.string   "place_of_birth",          limit: 256
    t.string   "emergency_contact",       limit: 256
    t.string   "languages_spoken",        limit: 256
    t.string   "complexion",              limit: 256
    t.string   "height",                  limit: 256
    t.string   "marital_status",          limit: 256
    t.string   "blood_type",              limit: 256
    t.string   "religion",                limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branches", force: :cascade do |t|
    t.integer  "entity_id",  limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "constants", force: :cascade do |t|
    t.string   "constant",    limit: 64
    t.string   "description", limit: 128
    t.string   "name",        limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_details", force: :cascade do |t|
    t.integer  "entity_id",  limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "digitals", force: :cascade do |t|
    t.integer  "contact_detail_id", limit: 4
    t.string   "url",               limit: 256
    t.string   "description",       limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", force: :cascade do |t|
    t.integer  "entity_id",  limit: 4
    t.string   "status",     limit: 64
    t.string   "rest_day",   limit: 64
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "entities", force: :cascade do |t|
    t.string   "name",        limit: 64
    t.string   "description", limit: 256
    t.string   "logo",        limit: 512
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entity_connectors", force: :cascade do |t|
    t.string   "relationship",      limit: 64
    t.string   "relationship_type", limit: 64
    t.integer  "entity_id",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_sets", force: :cascade do |t|
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "path",              limit: 512
    t.string   "description",       limit: 128
    t.integer  "rel_file_set_id",   limit: 4
    t.string   "rel_file_set_type", limit: 255
  end

  create_table "holiday_types", force: :cascade do |t|
    t.string   "type_name",                           limit: 64
    t.decimal  "additional_rate",                                precision: 16, scale: 2
    t.decimal  "additional_rate_overtime",                       precision: 16, scale: 2
    t.decimal  "additional_rate_rest_day_priveleges",            precision: 16, scale: 2
    t.boolean  "no_work_pay",                         limit: 1,                           default: false
    t.datetime "created_at",                                                                              null: false
    t.datetime "updated_at",                                                                              null: false
  end

  create_table "holidays", force: :cascade do |t|
    t.integer  "holiday_type_id",        limit: 4
    t.date     "date_of_implementation"
    t.string   "description",            limit: 256
    t.string   "name",                   limit: 64
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "institution_employees", force: :cascade do |t|
    t.integer  "entity_id",         limit: 4
    t.string   "compensation_type", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "institutional_adjustment_sets", force: :cascade do |t|
    t.integer "employee_id",                 limit: 4
    t.integer "institution_employee_id",     limit: 4
    t.integer "institutional_adjustment_id", limit: 4
    t.string  "institutional_ID",            limit: 255
    t.boolean "activated",                   limit: 1,   default: true
  end

  create_table "institutional_adjustments", force: :cascade do |t|
    t.integer  "institution_employee_id", limit: 4
    t.decimal  "start_range",                         precision: 16, scale: 2
    t.decimal  "end_range",                           precision: 16, scale: 2
    t.decimal  "employer_contribution",               precision: 16, scale: 2
    t.decimal  "employee_contribution",               precision: 16, scale: 2
    t.string   "period_of_time",          limit: 16
    t.string   "description",             limit: 256
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
  end

  create_table "link_sets", force: :cascade do |t|
    t.string   "label",             limit: 128
    t.string   "url",               limit: 512
    t.integer  "rel_link_set_id",   limit: 4
    t.string   "rel_link_set_type", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "lump_adjustments", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.decimal  "amount",                  precision: 16, scale: 2
    t.string   "signed_type", limit: 64
    t.string   "description", limit: 256
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "performance_appraisals", force: :cascade do |t|
    t.integer  "employee_id", limit: 4
    t.string   "description", limit: 256
    t.string   "category",    limit: 64
    t.decimal  "score",                   precision: 16, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "rate_adjustments", force: :cascade do |t|
    t.integer  "employee_id",  limit: 4
    t.decimal  "amount",                  precision: 16, scale: 2
    t.string   "signed_type",  limit: 64
    t.string   "rate_of_time", limit: 64
    t.string   "description",  limit: 64
    t.boolean  "activated",    limit: 1,                           default: true
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  create_table "repaid_vales", force: :cascade do |t|
    t.integer  "vale_id",    limit: 4
    t.decimal  "amount",               precision: 16, scale: 2
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
  end

  create_table "telephones", force: :cascade do |t|
    t.integer  "contact_detail_id", limit: 4
    t.string   "digits",            limit: 32
    t.string   "description",       limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vales", force: :cascade do |t|
    t.integer  "employee_id",     limit: 4
    t.decimal  "amount",                     precision: 16, scale: 2
    t.string   "description",     limit: 64
    t.decimal  "rate_of_payment",            precision: 16, scale: 2
    t.string   "rate_of_time",    limit: 64
    t.string   "status",          limit: 64,                          default: "AWAITING"
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
  end

  create_table "verifications", force: :cascade do |t|
    t.integer  "access_id",  limit: 4
    t.string   "temp_email", limit: 64
    t.string   "hashlink",   limit: 512
    t.boolean  "verified",   limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
