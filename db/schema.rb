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

ActiveRecord::Schema.define(version: 20160415003506) do

  create_table "accesses", force: :cascade do |t|
    t.string   "actor_id",        limit: 36
    t.string   "username",        limit: 64
    t.string   "password_digest", limit: 512
    t.string   "email",           limit: 512
    t.string   "hash_link",       limit: 512
    t.integer  "attempts",        limit: 1,   default: 0
    t.datetime "last_login"
    t.boolean  "verification",    limit: 1,   default: false
    t.boolean  "remember_me",     limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actor_connectors", force: :cascade do |t|
    t.string   "relationship",      limit: 64
    t.string   "relationship_type", limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actors", force: :cascade do |t|
    t.string   "name",        limit: 64
    t.string   "description", limit: 256
    t.string   "logo",        limit: 512
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", force: :cascade do |t|
    t.string   "rel_model_id",   limit: 36
    t.string   "rel_model_type", limit: 36
    t.string   "description",    limit: 256
    t.decimal  "longitude",                  precision: 18, scale: 12
    t.decimal  "latitude",                   precision: 18, scale: 12
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses_actors", id: false, force: :cascade do |t|
    t.string   "id",         limit: 36, null: false
    t.string   "actor_id",   limit: 36
    t.string   "address_id", limit: 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "associations", id: false, force: :cascade do |t|
    t.string   "id",           limit: 36
    t.string   "remarks",      limit: 256
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.string   "model_one",    limit: 36
    t.string   "model_one_id", limit: 36
    t.string   "model_two",    limit: 36
    t.string   "model_two_id", limit: 36
  end

  create_table "attendances", force: :cascade do |t|
    t.string   "employee_id",        limit: 36
    t.date     "date_of_attendance"
    t.time     "timein",                         default: '2000-01-01 00:00:01'
    t.time     "timeout",                        default: '2000-01-01 23:59:59'
    t.string   "remark",             limit: 256
    t.datetime "created_at",                                                     null: false
    t.datetime "updated_at",                                                     null: false
  end

  create_table "base_rates", force: :cascade do |t|
    t.string   "employee_id",          limit: 36
    t.boolean  "signed_type",          limit: 1
    t.decimal  "amount",                           precision: 16, scale: 2
    t.string   "period_of_time",       limit: 64
    t.string   "rate_type",            limit: 64,                           default: "other"
    t.string   "remark",               limit: 256
    t.datetime "start_of_effectivity"
    t.datetime "end_of_effectivity"
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
  end

  create_table "biodata", force: :cascade do |t|
    t.string   "actor_id",                limit: 36
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
    t.decimal  "height_cm",                           precision: 10
    t.string   "marital_status",          limit: 256
    t.string   "blood_type",              limit: 256
    t.string   "religion",                limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branches", force: :cascade do |t|
    t.string   "name",       limit: 36
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "constants", force: :cascade do |t|
    t.string   "value",               limit: 64
    t.string   "name",                limit: 256
    t.string   "constant_type",       limit: 64
    t.datetime "date_of_effectivity"
    t.string   "remark",              limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", force: :cascade do |t|
    t.string   "description", limit: 256
    t.string   "label",       limit: 64
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "digitals", force: :cascade do |t|
    t.string   "rel_model_id",   limit: 36
    t.string   "rel_model_type", limit: 36
    t.string   "url",            limit: 512
    t.string   "description",    limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "digitals_actors", id: false, force: :cascade do |t|
    t.string   "id",         limit: 36, null: false
    t.string   "actor_id",   limit: 36
    t.string   "digital_id", limit: 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "duty_statuses", force: :cascade do |t|
    t.string   "remark",              limit: 256
    t.boolean  "active",              limit: 1,   default: false
    t.string   "employee_id",         limit: 36
    t.datetime "date_of_effectivity",             default: '2016-04-15 11:00:31'
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  create_table "employees", force: :cascade do |t|
    t.string   "actor_id",   limit: 36
    t.string   "branch_id",  limit: 36
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "expenses", force: :cascade do |t|
    t.decimal  "amount",                          precision: 16, scale: 2
    t.string   "category",            limit: 256
    t.string   "physical_id",         limit: 256
    t.string   "remark",              limit: 256
    t.datetime "date_of_effectivity"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "expenses_actors", id: false, force: :cascade do |t|
    t.string   "id",         limit: 36, null: false
    t.string   "actor_id",   limit: 36
    t.string   "expense_id", limit: 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "file_sets", force: :cascade do |t|
    t.string   "file",              limit: 512
    t.string   "label",             limit: 256
    t.string   "rel_file_set_id",   limit: 36
    t.string   "rel_file_set_type", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "holiday_types", force: :cascade do |t|
    t.string   "type_name",                    limit: 64
    t.decimal  "rate_multiplier",                         precision: 16, scale: 2
    t.decimal  "overtime_multiplier",                     precision: 16, scale: 2
    t.decimal  "rest_day_multiplier",                     precision: 16, scale: 2
    t.decimal  "overtime_rest_day_multiplier",            precision: 16, scale: 2
    t.boolean  "no_work_pay",                  limit: 1,                           default: false
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
  end

  create_table "holidays", force: :cascade do |t|
    t.string   "holiday_type_id",        limit: 36
    t.string   "description",            limit: 256
    t.string   "name",                   limit: 64
    t.date     "date_of_implementation"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "image_sets", force: :cascade do |t|
    t.string   "picture",            limit: 512
    t.string   "description",        limit: 256
    t.integer  "priority",           limit: 4,   default: 0
    t.string   "rel_image_set_id",   limit: 36
    t.string   "rel_image_set_type", limit: 255
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
  end

  create_table "institutional_adjustments", force: :cascade do |t|
    t.string   "institution",           limit: 64
    t.string   "contribution_type",     limit: 64,                           default: "LUMP"
    t.decimal  "start_range",                       precision: 16, scale: 2
    t.decimal  "end_range",                         precision: 16, scale: 2
    t.decimal  "employer_contribution",             precision: 16, scale: 2
    t.decimal  "employee_contribution",             precision: 16, scale: 2
    t.string   "period_of_time",        limit: 64
    t.string   "description",           limit: 256
    t.datetime "date_of_effectivity"
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
  end

  create_table "leaves", force: :cascade do |t|
    t.string   "employee_id",          limit: 36
    t.string   "type_of_leave",        limit: 64
    t.datetime "start_of_effectivity",             default: '2016-04-15 11:00:34'
    t.datetime "end_of_effectivity",               default: '2016-04-15 11:00:34'
    t.string   "remark",               limit: 256
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
  end

  create_table "link_sets", force: :cascade do |t|
    t.string   "label",             limit: 64
    t.string   "url",               limit: 512
    t.string   "rel_link_set_id",   limit: 36
    t.string   "rel_link_set_type", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "lump_adjustments", force: :cascade do |t|
    t.decimal  "amount",                          precision: 16, scale: 2
    t.boolean  "signed_type",         limit: 1,                            default: true
    t.string   "remark",              limit: 256
    t.string   "employee_id",         limit: 36
    t.datetime "date_of_effectivity"
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
  end

  create_table "payroll_settings", force: :cascade do |t|
    t.string   "employee_id",         limit: 36
    t.string   "SSS_ID",              limit: 64
    t.string   "PHILHEALTH_ID",       limit: 64
    t.string   "PAGIBIG_ID",          limit: 64
    t.string   "BIR_ID",              limit: 64
    t.boolean  "SSS_status",          limit: 1,   default: false
    t.boolean  "PHILHEALTH_status",   limit: 1,   default: false
    t.boolean  "PAGIBIG_status",      limit: 1,   default: false
    t.boolean  "BIR_status",          limit: 1,   default: false
    t.datetime "date_of_effectivity",             default: '2016-04-15 11:00:35'
    t.string   "remark",              limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "performance_appraisals", force: :cascade do |t|
    t.string   "employee_id", limit: 36
    t.string   "description", limit: 256
    t.string   "category",    limit: 64
    t.decimal  "score",                   precision: 16, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "permissions", force: :cascade do |t|
    t.string   "access_id",  limit: 36
    t.string   "can",        limit: 256
    t.string   "remark",     limit: 256
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "positions", force: :cascade do |t|
    t.string   "description",   limit: 256
    t.string   "label",         limit: 64
    t.string   "department_id", limit: 36
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "rate_adjustments", force: :cascade do |t|
    t.string   "employee_id",  limit: 36
    t.decimal  "amount",                   precision: 16, scale: 2
    t.string   "signed_type",  limit: 64
    t.string   "rate_of_time", limit: 64
    t.string   "description",  limit: 256
    t.boolean  "activated",    limit: 1,                            default: true
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
  end

  create_table "regular_work_periods", force: :cascade do |t|
    t.time     "start_time",                      default: '2000-01-01 08:00:00'
    t.time     "end_time",                        default: '2000-01-01 17:00:00'
    t.datetime "date_of_effectivity",             default: '2016-04-15 11:00:28'
    t.string   "remark",              limit: 256
    t.string   "employee_id",         limit: 36
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
  end

  create_table "rest_days", force: :cascade do |t|
    t.string   "day",                 limit: 64, default: "SUNDAY"
    t.string   "employee_id",         limit: 36
    t.datetime "date_of_effectivity"
    t.datetime "created_at",                                        null: false
    t.datetime "updated_at",                                        null: false
  end

  create_table "telephones", force: :cascade do |t|
    t.string   "rel_model_id",   limit: 36
    t.string   "rel_model_type", limit: 36
    t.string   "digits",         limit: 64
    t.string   "description",    limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "telephones_actors", id: false, force: :cascade do |t|
    t.string   "id",           limit: 36, null: false
    t.string   "actor_id",     limit: 36
    t.string   "telephone_id", limit: 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vale_adjustments", force: :cascade do |t|
    t.decimal  "amount",                          precision: 16, scale: 2
    t.boolean  "signed_type",         limit: 1,                            default: true
    t.string   "remark",              limit: 256
    t.string   "vale_id",             limit: 36
    t.datetime "date_of_effectivity"
    t.datetime "created_at",                                                              null: false
    t.datetime "updated_at",                                                              null: false
  end

  create_table "vales", force: :cascade do |t|
    t.boolean  "approval_status",     limit: 1,                            default: false
    t.decimal  "amount",                          precision: 16, scale: 2
    t.decimal  "amount_of_deduction",             precision: 16, scale: 2
    t.string   "period_of_deduction", limit: 64
    t.string   "remark",              limit: 256
    t.string   "employee_id",         limit: 36
    t.datetime "date_of_effectivity"
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
  end

  create_table "vehicles", force: :cascade do |t|
    t.string   "type_of_vehicle",      limit: 64
    t.string   "plate_number",         limit: 64
    t.string   "orcr",                 limit: 64
    t.string   "remark",               limit: 256
    t.datetime "date_of_registration"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
