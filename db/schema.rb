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

ActiveRecord::Schema.define(version: 20180104130842) do

  create_table "episodes", force: :cascade do |t|
    t.integer "podcast_id", null: false
    t.string "gd_name", null: false
    t.string "gd_id", null: false
    t.string "gd_web_view_link", null: false
    t.datetime "gd_created_time", null: false
    t.datetime "gd_modified_time", null: false
    t.string "gd_mime_type", null: false
    t.integer "gd_size", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "get_order", default: 0, null: false
    t.index ["podcast_id", "gd_id"], name: "index_episodes_on_podcast_id_and_gd_id", unique: true
    t.index ["podcast_id"], name: "index_episodes_on_podcast_id"
  end

  create_table "googleauths", force: :cascade do |t|
    t.string "key", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["key"], name: "index_googleauths_on_key", unique: true
  end

  create_table "podcasts", force: :cascade do |t|
    t.string "title", null: false
    t.string "query", null: false
    t.string "order_by", default: "createdTime desc", null: false
    t.integer "max_count", default: 10, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
