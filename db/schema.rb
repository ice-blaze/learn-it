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

ActiveRecord::Schema.define(version: 20140526172212) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "comment_functions", force: true do |t|
    t.text     "content"
    t.integer  "like"
    t.integer  "dislike"
    t.datetime "date"
    t.integer  "function_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_functions", ["function_id"], name: "index_comment_functions_on_function_id", using: :btree

  create_table "comment_interpreters", force: true do |t|
    t.text     "content"
    t.integer  "like"
    t.integer  "dislike"
    t.datetime "date"
    t.integer  "interpreter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_interpreters", ["interpreter_id"], name: "index_comment_interpreters_on_interpreter_id", using: :btree

  create_table "comment_parts", force: true do |t|
    t.text     "content"
    t.integer  "like"
    t.integer  "dislike"
    t.datetime "date"
    t.integer  "part_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_parts", ["part_id"], name: "index_comment_parts_on_part_id", using: :btree

  create_table "comment_tutorials", force: true do |t|
    t.text     "content"
    t.integer  "like"
    t.integer  "dislike"
    t.datetime "date"
    t.integer  "tutorial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comment_tutorials", ["tutorial_id"], name: "index_comment_tutorials_on_tutorial_id", using: :btree

  create_table "functions", force: true do |t|
    t.string   "name"
    t.text     "regex"
    t.text     "content"
    t.integer  "interpreter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "functions", ["interpreter_id"], name: "index_functions_on_interpreter_id", using: :btree

  create_table "grade_interpreters", force: true do |t|
    t.float    "grade"
    t.integer  "user_id"
    t.integer  "interpreter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grade_interpreters", ["interpreter_id"], name: "index_grade_interpreters_on_interpreter_id", using: :btree
  add_index "grade_interpreters", ["user_id"], name: "index_grade_interpreters_on_user_id", using: :btree

  create_table "grade_tutorials", force: true do |t|
    t.float    "grade"
    t.integer  "user_id"
    t.integer  "tutorial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "grade_tutorials", ["tutorial_id"], name: "index_grade_tutorials_on_tutorial_id", using: :btree
  add_index "grade_tutorials", ["user_id"], name: "index_grade_tutorials_on_user_id", using: :btree

  create_table "interpreters", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "is_finish"
    t.string   "open_token"
    t.string   "close_token"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version"
  end

  add_index "interpreters", ["user_id"], name: "index_interpreters_on_user_id", using: :btree

  create_table "parts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "signature"
    t.integer  "tutorial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "parts", ["tutorial_id"], name: "index_parts_on_tutorial_id", using: :btree

  create_table "tutorials", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.boolean  "is_finish"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "version"
    t.string   "interpreter_id"
  end

  add_index "tutorials", ["interpreter_id"], name: "index_tutorials_on_interpreter_id", using: :btree
  add_index "tutorials", ["user_id"], name: "index_tutorials_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end