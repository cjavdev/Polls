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

ActiveRecord::Schema.define(:version => 20130530205822) do

  create_table "answers", :force => true do |t|
    t.integer  "respondent_id"
    t.integer  "response_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "answers", ["respondent_id"], :name => "index_answers_on_respondent_id"
  add_index "answers", ["response_id"], :name => "response_id_idx"

  create_table "polls", :force => true do |t|
    t.string   "name"
    t.integer  "creator_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "polls", ["creator_id"], :name => "index_polls_on_creator_id"

  create_table "questions", :force => true do |t|
    t.integer  "poll_id"
    t.string   "question"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "questions", ["poll_id"], :name => "poll_id_idx"

  create_table "responses", :force => true do |t|
    t.integer  "question_id"
    t.string   "response"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "responses", ["question_id"], :name => "index_responses_on_question_id"

  create_table "team_users", :force => true do |t|
    t.integer  "user_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "team_users", ["team_id"], :name => "index_team_users_on_team_id"
  add_index "team_users", ["user_id"], :name => "index_team_users_on_user_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "captain_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "teams", ["captain_id"], :name => "index_teams_on_captain_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

end
