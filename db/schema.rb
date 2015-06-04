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

ActiveRecord::Schema.define(version: 20150603204845) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "decisions", force: :cascade do |t|
    t.string   "context",                   null: false
    t.boolean  "is_active",  default: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "participations", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "decision_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "participations", ["decision_id"], name: "index_participations_on_decision_id", using: :btree
  add_index "participations", ["user_id"], name: "index_participations_on_user_id", using: :btree

  create_table "proposals", force: :cascade do |t|
    t.string   "status",           default: "open"
    t.string   "proposed_idea"
    t.uuid     "participation_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  create_table "queries", force: :cascade do |t|
    t.integer  "proposal_id"
    t.uuid     "participation_id"
    t.string   "status",           default: "waiting"
    t.datetime "respond_by"
    t.datetime "responded_at"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "queries", ["proposal_id"], name: "index_queries_on_proposal_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_foreign_key "participations", "decisions"
  add_foreign_key "participations", "users"
  add_foreign_key "proposals", "participations"
  add_foreign_key "queries", "participations"
  add_foreign_key "queries", "proposals"
end
