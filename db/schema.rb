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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121112230121) do

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "categories", :force => true do |t|
    t.string "name", :limit => 32, :null => false
  end

  add_index "categories", ["name"], :name => "index_categories_on_name", :unique => true

  create_table "credentials", :force => true do |t|
    t.integer  "user_id",                                      :null => false
    t.string   "type",       :limit => 32,                     :null => false
    t.string   "name",       :limit => 128
    t.boolean  "verified",                  :default => false, :null => false
    t.datetime "updated_at",                                   :null => false
    t.binary   "key"
  end

  add_index "credentials", ["type", "name"], :name => "index_credentials_on_type_and_name", :unique => true
  add_index "credentials", ["type", "updated_at"], :name => "index_credentials_on_type_and_updated_at"
  add_index "credentials", ["user_id", "type"], :name => "index_credentials_on_user_id_and_type"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "endpoints", :force => true do |t|
    t.string "name", :limit => 128, :null => false
    t.string "url",  :limit => 256, :null => false
  end

  add_index "endpoints", ["name"], :name => "index_endpoints_on_name", :unique => true
  add_index "endpoints", ["url"], :name => "index_endpoints_on_url", :unique => true

  create_table "problems", :force => true do |t|
    t.integer "category_id",                         :null => false
    t.integer "endpoint_id",                         :null => false
    t.string  "name",                                :null => false
    t.string  "task_name",                           :null => false
    t.boolean "published",        :default => false, :null => false
    t.text    "description_html",                    :null => false
  end

  add_index "problems", ["name"], :name => "index_problems_on_name", :unique => true
  add_index "problems", ["task_name"], :name => "index_problems_on_task_name", :unique => true

  create_table "submissions", :force => true do |t|
    t.integer  "user_id",                   :null => false
    t.integer  "problem_id",                :null => false
    t.string   "remote_ip",  :limit => 128, :null => false
    t.text     "code",                      :null => false
    t.datetime "created_at",                :null => false
  end

  add_index "submissions", ["problem_id", "created_at"], :name => "index_submissions_on_problem_id_and_created_at"
  add_index "submissions", ["user_id", "problem_id", "created_at"], :name => "index_submissions_on_user_id_and_problem_id_and_created_at", :unique => true

  create_table "users", :force => true do |t|
    t.string   "exuid",      :limit => 32,                    :null => false
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.boolean  "admin",                    :default => false, :null => false
  end

  add_index "users", ["exuid"], :name => "index_users_on_exuid", :unique => true

  create_table "verdicts", :force => true do |t|
    t.integer  "submission_id", :null => false
    t.decimal  "score",         :null => false
    t.decimal  "max_score",     :null => false
    t.text     "message",       :null => false
    t.datetime "created_at",    :null => false
  end

  add_index "verdicts", ["submission_id"], :name => "index_verdicts_on_submission_id", :unique => true

end
