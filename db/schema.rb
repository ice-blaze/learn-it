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

ActiveRecord::Schema.define(version: 20140617114431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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

  create_table "done_parts", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "part_id"
  end

  add_index "done_parts", ["part_id"], name: "index_done_parts_on_part_id", using: :btree
  add_index "done_parts", ["user_id"], name: "index_done_parts_on_user_id", using: :btree

  create_table "function_comment_votes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "function_comment_id"
    t.boolean  "positive"
  end

  add_index "function_comment_votes", ["function_comment_id"], name: "index_function_comment_votes_on_function_comment_id", using: :btree
  add_index "function_comment_votes", ["user_id"], name: "index_function_comment_votes_on_user_id", using: :btree

  create_table "function_comments", force: true do |t|
    t.text     "content"
    t.integer  "like"
    t.integer  "dislike"
    t.integer  "function_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "function_comments", ["function_id"], name: "index_function_comments_on_function_id", using: :btree
  add_index "function_comments", ["user_id"], name: "index_function_comments_on_user_id", using: :btree

  create_table "function_votes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "positive"
    t.integer  "user_id"
    t.integer  "function_id"
  end

  add_index "function_votes", ["function_id"], name: "index_function_votes_on_function_id", using: :btree
  add_index "function_votes", ["user_id"], name: "index_function_votes_on_user_id", using: :btree

  create_table "functions", force: true do |t|
    t.string   "name"
    t.text     "regex"
    t.text     "content"
    t.integer  "interpreter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "description"
  end

  add_index "functions", ["interpreter_id"], name: "index_functions_on_interpreter_id", using: :btree

  create_table "interpreter_comment_votes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "interpreter_comment_id"
    t.boolean  "positive"
  end

  add_index "interpreter_comment_votes", ["interpreter_comment_id"], name: "index_interpreter_comment_votes_on_interpreter_comment_id", using: :btree
  add_index "interpreter_comment_votes", ["user_id"], name: "index_interpreter_comment_votes_on_user_id", using: :btree

  create_table "interpreter_comments", force: true do |t|
    t.text     "content"
    t.integer  "like"
    t.integer  "dislike"
    t.integer  "interpreter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "interpreter_comments", ["interpreter_id"], name: "index_interpreter_comments_on_interpreter_id", using: :btree
  add_index "interpreter_comments", ["user_id"], name: "index_interpreter_comments_on_user_id", using: :btree

  create_table "interpreter_grades", force: true do |t|
    t.decimal  "grade",          precision: 11, scale: 0
    t.integer  "user_id"
    t.integer  "interpreter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "interpreter_grades", ["interpreter_id"], name: "index_interpreter_grades_on_interpreter_id", using: :btree
  add_index "interpreter_grades", ["user_id"], name: "index_interpreter_grades_on_user_id", using: :btree

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

  create_table "part_comment_votes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "part_comment_id"
    t.boolean  "positive"
  end

  add_index "part_comment_votes", ["part_comment_id"], name: "index_part_comment_votes_on_part_comment_id", using: :btree
  add_index "part_comment_votes", ["user_id"], name: "index_part_comment_votes_on_user_id", using: :btree

  create_table "part_comments", force: true do |t|
    t.text     "content"
    t.integer  "like"
    t.integer  "dislike"
    t.integer  "part_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "part_comments", ["part_id"], name: "index_part_comments_on_part_id", using: :btree
  add_index "part_comments", ["user_id"], name: "index_part_comments_on_user_id", using: :btree

  create_table "part_votes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "positive"
    t.integer  "user_id"
    t.integer  "part_id"
  end

  add_index "part_votes", ["part_id"], name: "index_part_votes_on_part_id", using: :btree
  add_index "part_votes", ["user_id"], name: "index_part_votes_on_user_id", using: :btree

  create_table "parts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.text     "signature"
    t.integer  "tutorial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "position"
  end

  add_index "parts", ["tutorial_id"], name: "index_parts_on_tutorial_id", using: :btree

  create_table "tutorial_comment_votes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "tutorial_comment_id"
    t.boolean  "positive"
  end

  add_index "tutorial_comment_votes", ["tutorial_comment_id"], name: "index_tutorial_comment_votes_on_tutorial_comment_id", using: :btree
  add_index "tutorial_comment_votes", ["user_id"], name: "index_tutorial_comment_votes_on_user_id", using: :btree

  create_table "tutorial_comments", force: true do |t|
    t.text     "content"
    t.integer  "like"
    t.integer  "dislike"
    t.integer  "tutorial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "tutorial_comments", ["tutorial_id"], name: "index_tutorial_comments_on_tutorial_id", using: :btree
  add_index "tutorial_comments", ["user_id"], name: "index_tutorial_comments_on_user_id", using: :btree

  create_table "tutorial_grades", force: true do |t|
    t.decimal  "grade",       precision: 11, scale: 0
    t.integer  "user_id"
    t.integer  "tutorial_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tutorial_grades", ["tutorial_id"], name: "index_tutorial_grades_on_tutorial_id", using: :btree
  add_index "tutorial_grades", ["user_id"], name: "index_tutorial_grades_on_user_id", using: :btree

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
