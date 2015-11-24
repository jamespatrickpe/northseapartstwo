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

ActiveRecord::Schema.define(version: 20151117155710) do

  create_table "accesses", id: false, force: :cascade do |t|
    t.string   "id",           limit: 36,                  null: false
    t.string   "actor_id",     limit: 36
    t.string   "username",     limit: 64
    t.string   "password",     limit: 512
    t.string   "email",        limit: 512
    t.string   "hashlink",     limit: 512
    t.boolean  "verification", limit: 1,   default: false
    t.boolean  "remember_me",  limit: 1,   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actor_connectors", id: false, force: :cascade do |t|
    t.string   "id",                limit: 36, null: false
    t.string   "relationship",      limit: 64
    t.string   "relationship_type", limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "actors", id: false, force: :cascade do |t|
    t.string   "id",          limit: 36,  null: false
    t.string   "name",        limit: 64
    t.string   "description", limit: 256
    t.string   "logo",        limit: 512
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "addresses", id: false, force: :cascade do |t|
    t.string   "id",                limit: 36,                            null: false
    t.string   "contact_detail_id", limit: 36
    t.string   "description",       limit: 256
    t.decimal  "longitude",                     precision: 18, scale: 12
    t.decimal  "latitude",                      precision: 18, scale: 12
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advanced_payments_to_employees", id: false, force: :cascade do |t|
    t.string   "id",              limit: 36,                                               null: false
    t.string   "employee_id",     limit: 36
    t.decimal  "amount",                     precision: 16, scale: 2
    t.string   "description",     limit: 64
    t.decimal  "rate_of_payment",            precision: 16, scale: 2
    t.string   "rate_of_time",    limit: 64
    t.string   "status",          limit: 64,                          default: "AWAITING"
    t.datetime "created_at",                                                               null: false
    t.datetime "updated_at",                                                               null: false
  end

  create_table "allowable_sets", id: false, force: :cascade do |t|
    t.string   "id",             limit: 36, null: false
    t.string   "access_id",      limit: 36
    t.string   "security_level", limit: 64
    t.string   "controller",     limit: 64
    t.string   "action",         limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "attendances", id: false, force: :cascade do |t|
    t.string   "id",          limit: 36,  null: false
    t.string   "employee_id", limit: 36
    t.datetime "timein"
    t.datetime "timeout"
    t.string   "description", limit: 256
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "base_rates", id: false, force: :cascade do |t|
    t.string   "id",                   limit: 36,                           null: false
    t.string   "employee_id",          limit: 36
    t.string   "signed_type",          limit: 64
    t.decimal  "amount",                           precision: 16, scale: 2
    t.string   "period_of_time",       limit: 64
    t.string   "description",          limit: 256
    t.datetime "start_of_effectivity"
    t.datetime "end_of_effectivity"
    t.datetime "created_at",                                                null: false
    t.datetime "updated_at",                                                null: false
  end

  create_table "biodata", id: false, force: :cascade do |t|
    t.string   "id",                      limit: 36,  null: false
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
    t.string   "height",                  limit: 256
    t.string   "marital_status",          limit: 256
    t.string   "blood_type",              limit: 256
    t.string   "religion",                limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "branches", id: false, force: :cascade do |t|
    t.string   "id",         limit: 36, null: false
    t.string   "actor_id",   limit: 36
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "constants", id: false, force: :cascade do |t|
    t.string   "id",          limit: 36,  null: false
    t.string   "constant",    limit: 64
    t.string   "description", limit: 256
    t.string   "name",        limit: 64
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contact_details", id: false, force: :cascade do |t|
    t.string   "id",         limit: 36, null: false
    t.string   "actor_id",   limit: 36
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "departments", id: false, force: :cascade do |t|
    t.string   "id",          limit: 36,  null: false
    t.string   "description", limit: 256
    t.string   "label",       limit: 64
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "digitals", id: false, force: :cascade do |t|
    t.string   "id",                limit: 36,  null: false
    t.string   "contact_detail_id", limit: 36
    t.string   "url",               limit: 512
    t.string   "description",       limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "duties", id: false, force: :cascade do |t|
    t.string   "id",          limit: 36,  null: false
    t.string   "description", limit: 256
    t.string   "label",       limit: 64
    t.string   "employee_id", limit: 36
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "employees", id: false, force: :cascade do |t|
    t.string   "id",         limit: 36, null: false
    t.string   "actor_id",   limit: 36
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "file_sets", id: false, force: :cascade do |t|
    t.string   "id",                limit: 36,  null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.string   "path",              limit: 512
    t.string   "description",       limit: 256
    t.string   "rel_file_set_id",   limit: 36
    t.string   "rel_file_set_type", limit: 255
  end

  create_table "holiday_types", id: false, force: :cascade do |t|
    t.string   "id",                                  limit: 36,                                          null: false
    t.string   "type_name",                           limit: 64
    t.decimal  "additional_rate",                                precision: 16, scale: 2
    t.decimal  "additional_rate_overtime",                       precision: 16, scale: 2
    t.decimal  "additional_rate_rest_day_priveleges",            precision: 16, scale: 2
    t.boolean  "no_work_pay",                         limit: 1,                           default: false
    t.datetime "created_at",                                                                              null: false
    t.datetime "updated_at",                                                                              null: false
  end

  create_table "holidays", id: false, force: :cascade do |t|
    t.string   "id",                     limit: 36,  null: false
    t.string   "description",            limit: 256
    t.string   "name",                   limit: 64
    t.string   "holiday_type_id",        limit: 36
    t.date     "date_of_implementation"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "institution_employees", id: false, force: :cascade do |t|
    t.string   "id",                limit: 36, null: false
    t.string   "compensation_type", limit: 64
    t.string   "actor_id",          limit: 36
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "institutional_adjustment_sets", id: false, force: :cascade do |t|
    t.string  "id",                          limit: 36,                 null: false
    t.string  "employee_id",                 limit: 36
    t.string  "institution_employee_id",     limit: 36
    t.string  "institutional_adjustment_id", limit: 36
    t.string  "institutional_ID",            limit: 512
    t.boolean "activated",                   limit: 1,   default: true
  end

  create_table "institutional_adjustments", id: false, force: :cascade do |t|
    t.string   "id",                      limit: 36,                           null: false
    t.string   "institution_employee_id", limit: 36
    t.decimal  "start_range",                         precision: 16, scale: 2
    t.decimal  "end_range",                           precision: 16, scale: 2
    t.decimal  "employer_contribution",               precision: 16, scale: 2
    t.decimal  "employee_contribution",               precision: 16, scale: 2
    t.string   "period_of_time",          limit: 64
    t.string   "description",             limit: 256
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
  end

  create_table "link_sets", id: false, force: :cascade do |t|
    t.string   "id",                limit: 36,  null: false
    t.string   "label",             limit: 64
    t.string   "url",               limit: 512
    t.string   "rel_link_set_id",   limit: 36
    t.string   "rel_link_set_type", limit: 255
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  create_table "lump_adjustments", id: false, force: :cascade do |t|
    t.string   "id",                  limit: 36,                           null: false
    t.decimal  "amount",                          precision: 16, scale: 2
    t.string   "signed_type",         limit: 64
    t.string   "description",         limit: 256
    t.string   "employee_id",         limit: 36
    t.datetime "date_of_effectivity"
    t.datetime "created_at",                                               null: false
    t.datetime "updated_at",                                               null: false
  end

  create_table "performance_appraisals", id: false, force: :cascade do |t|
    t.string   "id",          limit: 36,                           null: false
    t.string   "employee_id", limit: 36
    t.string   "description", limit: 256
    t.string   "category",    limit: 64
    t.decimal  "score",                   precision: 16, scale: 2
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  create_table "positions", id: false, force: :cascade do |t|
    t.string   "id",            limit: 36,  null: false
    t.string   "description",   limit: 256
    t.string   "label",         limit: 64
    t.string   "department_id", limit: 36
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "rate_adjustments", id: false, force: :cascade do |t|
    t.string   "id",           limit: 36,                                          null: false
    t.string   "employee_id",  limit: 36
    t.decimal  "amount",                   precision: 16, scale: 2
    t.string   "signed_type",  limit: 64
    t.string   "rate_of_time", limit: 64
    t.string   "description",  limit: 256
    t.boolean  "activated",    limit: 1,                            default: true
    t.datetime "created_at",                                                       null: false
    t.datetime "updated_at",                                                       null: false
  end

  create_table "regular_work_periods", id: false, force: :cascade do |t|
    t.string   "id",          limit: 36, null: false
    t.time     "start"
    t.time     "end"
    t.string   "employee_id", limit: 36
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "repaid_payments_from_employees", id: false, force: :cascade do |t|
    t.string   "id",                               limit: 36,                          null: false
    t.decimal  "amount",                                      precision: 16, scale: 2
    t.string   "advanced_payments_to_employee_id", limit: 36
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
  end

  create_table "restdays", id: false, force: :cascade do |t|
    t.string   "id",          limit: 36,                    null: false
    t.string   "day",         limit: 64, default: "SUNDAY"
    t.string   "employee_id", limit: 36
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "roles", id: false, force: :cascade do |t|
    t.string   "id",         limit: 36,  null: false
    t.string   "access_id",  limit: 36
    t.string   "label",      limit: 256
    t.string   "level",      limit: 256
    t.string   "remark",     limit: 256
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "telephones", id: false, force: :cascade do |t|
    t.string   "id",                limit: 36,  null: false
    t.string   "contact_detail_id", limit: 36
    t.string   "digits",            limit: 64
    t.string   "description",       limit: 256
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
