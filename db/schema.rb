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

ActiveRecord::Schema.define(version: 20160515170935) do

  create_table "addresses", force: :cascade do |t|
    t.text     "street"
    t.text     "city"
    t.text     "state"
    t.text     "zip_cep"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "candidate_id"
  end

  add_index "addresses", ["candidate_id"], name: "index_addresses_on_candidate_id"

  create_table "applications", force: :cascade do |t|
    t.integer  "candidate_id"
    t.integer  "job_id"
    t.integer  "company_id"
    t.float    "candidate_match"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "applications", ["candidate_id"], name: "index_applications_on_candidate_id"
  add_index "applications", ["company_id"], name: "index_applications_on_company_id"
  add_index "applications", ["job_id"], name: "index_applications_on_job_id"

  create_table "candidates", force: :cascade do |t|
    t.text     "first_name"
    t.text     "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "companies", force: :cascade do |t|
    t.text     "about"
    t.text     "why"
    t.text     "mission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "name"
  end

  create_table "jobs", force: :cascade do |t|
    t.text    "title"
    t.text    "salary"
    t.text    "job_type"
    t.text    "description"
    t.text    "about"
    t.integer "company_id"
  end

  add_index "jobs", ["company_id"], name: "index_jobs_on_company_id"

  create_table "requirements", force: :cascade do |t|
    t.text     "title"
    t.integer  "years"
    t.integer  "job_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "requirements", ["job_id"], name: "index_requirements_on_job_id"

  create_table "skills", force: :cascade do |t|
    t.text     "title"
    t.integer  "years"
    t.integer  "candidate_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "skills", ["candidate_id"], name: "index_skills_on_candidate_id"

end
