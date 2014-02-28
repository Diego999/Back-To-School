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

ActiveRecord::Schema.define(version: 20140228125601) do

  create_table "discussions", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "discussions_establishments", force: true do |t|
    t.integer "discussion_id"
    t.integer "establishment_id"
  end

  add_index "discussions_establishments", ["discussion_id"], name: "index_discussions_establishments_on_discussion_id", using: :btree
  add_index "discussions_establishments", ["establishment_id", "discussion_id"], name: "index_dis_est", using: :btree

  create_table "discussions_promotions", force: true do |t|
    t.integer "discussion_id"
    t.integer "promotion_id"
  end

  add_index "discussions_promotions", ["discussion_id"], name: "index_discussions_promotions_on_discussion_id", using: :btree
  add_index "discussions_promotions", ["promotion_id", "discussion_id"], name: "index_discussions_promotions_on_promotion_id_and_discussion_id", using: :btree

  create_table "discussions_users", force: true do |t|
    t.integer "discussion_id"
    t.integer "user_id"
  end

  add_index "discussions_users", ["discussion_id"], name: "index_discussions_users_on_discussion_id", using: :btree
  add_index "discussions_users", ["user_id", "discussion_id"], name: "index_discussions_users_on_user_id_and_discussion_id", using: :btree

  create_table "establishments", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.date     "date"
    t.string   "name"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "discussion_id"
    t.integer  "user_id"
  end

  add_index "events", ["discussion_id"], name: "index_events_on_discussion_id", using: :btree
  add_index "events", ["user_id"], name: "index_events_on_user_id", using: :btree

  create_table "followers", force: true do |t|
    t.boolean  "accepted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "promotion_id"
    t.integer  "user_id"
  end

  add_index "followers", ["promotion_id"], name: "index_followers_on_promotion_id", using: :btree
  add_index "followers", ["user_id"], name: "index_followers_on_user_id", using: :btree

  create_table "messages", force: true do |t|
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "discussion_id"
    t.integer  "user_id"
  end

  add_index "messages", ["discussion_id"], name: "index_messages_on_discussion_id", using: :btree
  add_index "messages", ["user_id"], name: "index_messages_on_user_id", using: :btree

  create_table "promotions", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "establishment_id"
  end

  add_index "promotions", ["establishment_id"], name: "index_promotions_on_establishment_id", using: :btree

  create_table "promotions_users", force: true do |t|
    t.integer "promotion_id"
    t.integer "user_id"
  end

  add_index "promotions_users", ["promotion_id"], name: "index_promotions_users_on_promotion_id", using: :btree
  add_index "promotions_users", ["user_id", "promotion_id"], name: "index_promotions_users_on_user_id_and_promotion_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "mail"
    t.string   "password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "establishment_id"
    t.boolean  "admin",            default: false
    t.boolean  "est_admin",        default: false
    t.boolean  "professor",        default: false
    t.boolean  "student",          default: false
  end

  add_index "users", ["establishment_id"], name: "index_users_on_establishment_id", using: :btree

end
