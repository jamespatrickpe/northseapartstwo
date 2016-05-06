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
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "actor_id",        limit: 36
    t.string   "username",        limit: 64
    t.string   "password_digest", limit: 512
    t.string   "email",           limit: 512
    t.string   "hash_link",       limit: 512
    t.integer  "attempts",        limit: 1,   default: 0
    t.datetime "last_login"
    t.boolean  "verification",    limit: 1,   default: false
    t.boolean  "remember_me",     limit: 1,   default: false
  end

  add_index "accesses", ["id"], name: "index_accesses_on_id", using: :btree

  create_table "actors", force: :cascade do |t|
    t.string   "remark",     limit: 256
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 64
    t.string   "logo",       limit: 512
  end

  add_index "actors", ["id"], name: "index_actors_on_id", using: :btree

  create_table "addresses", force: :cascade do |t|
    t.string   "remark",           limit: 256
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "addressable_id",   limit: 255
    t.string   "addressable_type", limit: 255
    t.decimal  "longitude",                    precision: 18, scale: 12
    t.decimal  "latitude",                     precision: 18, scale: 12
  end

  add_index "addresses", ["id"], name: "index_addresses_on_id", using: :btree

  create_table "associations", force: :cascade do |t|
    t.string   "remark",         limit: 256
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "model_one_type", limit: 36
    t.string   "model_one_id",   limit: 36
    t.string   "model_two_type", limit: 36
    t.string   "model_two_id",   limit: 36
  end

  add_index "associations", ["id"], name: "index_associations_on_id", using: :btree

  create_table "attendances", force: :cascade do |t|
    t.string   "remark",                 limit: 256
    t.datetime "created_at",                                                         null: false
    t.datetime "updated_at",                                                         null: false
    t.string   "employee_id",            limit: 36
    t.date     "date_of_implementation",             default: '2016-05-06'
    t.time     "timein",                             default: '2000-01-01 00:00:01'
    t.time     "timeout",                            default: '2000-01-01 23:59:59'
  end

  add_index "attendances", ["id"], name: "index_attendances_on_id", using: :btree

  create_table "base_rates", force: :cascade do |t|
    t.string   "remark",               limit: 256
    t.datetime "created_at",                                                                  null: false
    t.datetime "updated_at",                                                                  null: false
    t.string   "employee_id",          limit: 36
    t.decimal  "amount",                           precision: 16, scale: 2
    t.string   "period_of_time",       limit: 64
    t.datetime "start_of_effectivity"
    t.datetime "end_of_effectivity"
    t.string   "rate_type",            limit: 64,                           default: "other"
  end

  add_index "base_rates", ["id"], name: "index_base_rates_on_id", using: :btree

  create_table "biodata", force: :cascade do |t|
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
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
  end

  add_index "biodata", ["id"], name: "index_biodata_on_id", using: :btree

  create_table "branches", force: :cascade do |t|
    t.string   "remark",     limit: 256
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 64
  end

  add_index "branches", ["id"], name: "index_branches_on_id", using: :btree

  create_table "constants", force: :cascade do |t|
    t.string   "remark",                 limit: 256
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "name",                   limit: 64
    t.date     "date_of_implementation",             default: '2016-05-06'
    t.string   "value",                  limit: 64
    t.string   "constant_type",          limit: 64
  end

  add_index "constants", ["id"], name: "index_constants_on_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "remark",     limit: 256
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "name",       limit: 64
  end

  add_index "departments", ["id"], name: "index_departments_on_id", using: :btree

  create_table "digitals", force: :cascade do |t|
    t.string   "remark",         limit: 256
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "digitable_id",   limit: 255
    t.string   "digitable_type", limit: 255
    t.string   "url",            limit: 512
  end

  add_index "digitals", ["id"], name: "index_digitals_on_id", using: :btree

  create_table "duty_statuses", force: :cascade do |t|
    t.string   "remark",                     limit: 256
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "employee_id",                limit: 36
    t.datetime "datetime_of_implementation"
    t.boolean  "active",                     limit: 1,   default: false
  end

  add_index "duty_statuses", ["id"], name: "index_duty_statuses_on_id", using: :btree

  create_table "employees", force: :cascade do |t|
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.string   "actor_id",   limit: 36
    t.string   "branch_id",  limit: 36
  end

  add_index "employees", ["id"], name: "index_employees_on_id", using: :btree

  create_table "expenses", force: :cascade do |t|
    t.string   "remark",                     limit: 256
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.decimal  "amount",                                 precision: 16, scale: 2
    t.datetime "datetime_of_implementation"
    t.string   "category",                   limit: 256
    t.string   "physical_id",                limit: 256
  end

  add_index "expenses", ["id"], name: "index_expenses_on_id", using: :btree

  create_table "file_sets", force: :cascade do |t|
    t.string   "remark",           limit: 256
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "filesetable_id",   limit: 255
    t.string   "filesetable_type", limit: 255
    t.string   "file",             limit: 512
  end

  add_index "file_sets", ["id"], name: "index_file_sets_on_id", using: :btree

  create_table "holiday_types", force: :cascade do |t|
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
    t.string   "type_name",                    limit: 64
    t.decimal  "rate_multiplier",                         precision: 16, scale: 2
    t.decimal  "overtime_multiplier",                     precision: 16, scale: 2
    t.decimal  "rest_day_multiplier",                     precision: 16, scale: 2
    t.decimal  "overtime_rest_day_multiplier",            precision: 16, scale: 2
    t.boolean  "no_work_pay",                  limit: 1,                           default: false
  end

  add_index "holiday_types", ["id"], name: "index_holiday_types_on_id", using: :btree

  create_table "holidays", force: :cascade do |t|
    t.string   "remark",                 limit: 256
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.date     "date_of_implementation",             default: '2016-05-06'
    t.string   "name",                   limit: 64
    t.string   "holiday_type_id",        limit: 36
  end

  add_index "holidays", ["id"], name: "index_holidays_on_id", using: :btree

  create_table "image_sets", force: :cascade do |t|
    t.string   "remark",            limit: 256
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.string   "imagesetable_id",   limit: 255
    t.string   "imagesetable_type", limit: 255
    t.string   "picture",           limit: 512
    t.integer  "priority",          limit: 4,   default: 0
  end

  add_index "image_sets", ["id"], name: "index_image_sets_on_id", using: :btree

  create_table "institutional_adjustments", force: :cascade do |t|
    t.string   "remark",                     limit: 256
    t.datetime "created_at",                                                                       null: false
    t.datetime "updated_at",                                                                       null: false
    t.string   "period_of_time",             limit: 64
    t.datetime "datetime_of_implementation"
    t.string   "institution",                limit: 64
    t.string   "contribution_type",          limit: 64,                           default: "LUMP"
    t.decimal  "start_range",                            precision: 16, scale: 2
    t.decimal  "end_range",                              precision: 16, scale: 2
    t.decimal  "employer_contribution",                  precision: 16, scale: 2
    t.decimal  "employee_contribution",                  precision: 16, scale: 2
  end

  add_index "institutional_adjustments", ["id"], name: "index_institutional_adjustments_on_id", using: :btree

  create_table "leaves", force: :cascade do |t|
    t.string   "remark",               limit: 256
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
    t.string   "employee_id",          limit: 36
    t.string   "type_of_leave",        limit: 64
    t.datetime "start_of_effectivity",             default: '2016-05-06 08:40:10'
    t.datetime "end_of_effectivity",               default: '2016-05-06 08:40:10'
  end

  add_index "leaves", ["id"], name: "index_leaves_on_id", using: :btree

  create_table "link_sets", force: :cascade do |t|
    t.string   "remark",           limit: 256
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.string   "url",              limit: 512
    t.string   "linksetable_id",   limit: 255
    t.string   "linksetable_type", limit: 255
  end

  add_index "link_sets", ["id"], name: "index_link_sets_on_id", using: :btree

  create_table "lump_adjustments", force: :cascade do |t|
    t.string   "remark",                     limit: 256
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.datetime "datetime_of_implementation"
    t.string   "employee_id",                limit: 36
    t.decimal  "amount",                                 precision: 16, scale: 2
  end

  add_index "lump_adjustments", ["id"], name: "index_lump_adjustments_on_id", using: :btree

  create_table "payroll_settings", force: :cascade do |t|
    t.string   "remark",                     limit: 256
    t.datetime "created_at",                                             null: false
    t.datetime "updated_at",                                             null: false
    t.string   "employee_id",                limit: 36
    t.datetime "datetime_of_implementation"
    t.string   "SSS_ID",                     limit: 64
    t.string   "PHILHEALTH_ID",              limit: 64
    t.string   "PAGIBIG_ID",                 limit: 64
    t.string   "BIR_ID",                     limit: 64
    t.boolean  "SSS_status",                 limit: 1,   default: false
    t.boolean  "PHILHEALTH_status",          limit: 1,   default: false
    t.boolean  "PAGIBIG_status",             limit: 1,   default: false
    t.boolean  "BIR_status",                 limit: 1,   default: false
  end

  add_index "payroll_settings", ["id"], name: "index_payroll_settings_on_id", using: :btree

  create_table "performance_appraisals", force: :cascade do |t|
    t.string   "remark",      limit: 256
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
    t.string   "employee_id", limit: 36
    t.string   "category",    limit: 64
    t.decimal  "score",                   precision: 16, scale: 2
  end

  add_index "performance_appraisals", ["id"], name: "index_performance_appraisals_on_id", using: :btree

  create_table "permissions", force: :cascade do |t|
    t.string   "remark",     limit: 256
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "access_id",  limit: 36
    t.string   "can",        limit: 256
  end

  add_index "permissions", ["id"], name: "index_permissions_on_id", using: :btree

  create_table "positions", force: :cascade do |t|
    t.string   "remark",        limit: 256
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.string   "name",          limit: 64
    t.string   "department_id", limit: 36
  end

  add_index "positions", ["id"], name: "index_positions_on_id", using: :btree

  create_table "regular_work_periods", force: :cascade do |t|
    t.string   "remark",                     limit: 256
    t.datetime "created_at",                                                             null: false
    t.datetime "updated_at",                                                             null: false
    t.datetime "datetime_of_implementation"
    t.string   "employee_id",                limit: 36
    t.time     "start_time",                             default: '2000-01-01 08:00:00'
    t.time     "end_time",                               default: '2000-01-01 17:00:00'
  end

  add_index "regular_work_periods", ["id"], name: "index_regular_work_periods_on_id", using: :btree

  create_table "rest_days", force: :cascade do |t|
    t.string   "remark",                     limit: 256
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
    t.string   "employee_id",                limit: 36
    t.datetime "datetime_of_implementation"
    t.string   "day",                        limit: 64,  default: "SUNDAY"
  end

  add_index "rest_days", ["id"], name: "index_rest_days_on_id", using: :btree

  create_table "telephones", force: :cascade do |t|
    t.string   "remark",            limit: 256
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "telephonable_id",   limit: 255
    t.string   "telephonable_type", limit: 255
    t.string   "digits",            limit: 64
  end

  add_index "telephones", ["id"], name: "index_telephones_on_id", using: :btree

  create_table "vale_adjustments", force: :cascade do |t|
    t.string   "remark",                     limit: 256
    t.datetime "created_at",                                                      null: false
    t.datetime "updated_at",                                                      null: false
    t.decimal  "amount",                                 precision: 16, scale: 2
    t.datetime "datetime_of_implementation"
    t.string   "vale_id",                    limit: 36
  end

  add_index "vale_adjustments", ["id"], name: "index_vale_adjustments_on_id", using: :btree

  create_table "vales", force: :cascade do |t|
    t.string   "remark",                     limit: 256
    t.datetime "created_at",                                                                      null: false
    t.datetime "updated_at",                                                                      null: false
    t.decimal  "amount",                                 precision: 16, scale: 2
    t.string   "employee_id",                limit: 36
    t.datetime "datetime_of_implementation"
    t.string   "period_of_time",             limit: 64
    t.boolean  "approval_status",            limit: 1,                            default: false
    t.decimal  "amount_of_deduction",                    precision: 16, scale: 2
  end

  add_index "vales", ["id"], name: "index_vales_on_id", using: :btree

  create_table "vehicles", force: :cascade do |t|
    t.string   "remark",                 limit: 256
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
    t.date     "date_of_implementation",                            default: '2016-05-06'
    t.decimal  "capacity_m3",                        precision: 10
    t.string   "type_of_vehicle",        limit: 64
    t.string   "plate_number",           limit: 64
    t.string   "orcr",                   limit: 64
  end

  add_index "vehicles", ["id"], name: "index_vehicles_on_id", using: :btree

end
