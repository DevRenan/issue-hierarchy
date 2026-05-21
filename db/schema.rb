# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_05_21_044119) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "attachments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "file_path"
    t.bigint "issue_id", null: false
    t.string "name"
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_attachments_on_issue_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", null: false
    t.bigint "issue_id", null: false
    t.datetime "updated_at", null: false
    t.index ["issue_id"], name: "index_comments_on_issue_id"
  end

  create_table "issues", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.bigint "node_id", null: false
    t.integer "priority"
    t.integer "status"
    t.string "title"
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.index ["node_id"], name: "index_issues_on_node_id"
    t.index ["workspace_id"], name: "index_issues_on_workspace_id"
  end

  create_table "nodes", force: :cascade do |t|
    t.string "ancestry"
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.string "node_type"
    t.datetime "updated_at", null: false
    t.bigint "workspace_id", null: false
    t.index ["workspace_id"], name: "index_nodes_on_workspace_id"
  end

  create_table "workspaces", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "name"
    t.datetime "updated_at", null: false
  end

  add_foreign_key "attachments", "issues"
  add_foreign_key "comments", "issues"
  add_foreign_key "issues", "nodes"
  add_foreign_key "issues", "workspaces"
  add_foreign_key "nodes", "workspaces"
end
