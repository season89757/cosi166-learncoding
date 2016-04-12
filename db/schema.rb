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

ActiveRecord::Schema.define(version: 20160412183727) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.string   "ISBN"
    t.string   "author"
    t.date     "publish_date"
    t.text     "description"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "image_url"
    t.string   "publisher"
    t.string   "total_pages"
    t.string   "written_language"
    t.string   "asin"
    t.string   "price"
    t.string   "similar_items"
    t.string   "average_rating"
    t.string   "ratings_count"
    t.string   "sales_rank"
    t.string   "preview_url"
    t.string   "reviews"
    t.string   "sale_url"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "book_id"
    t.text     "title"
    t.text     "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "like"
  end

  add_index "comments", ["book_id"], name: "index_comments_on_book_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "domains", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "forums", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.string   "name"
    t.string   "base64"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string   "name"
    t.integer  "popularity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "postreplies", force: :cascade do |t|
    t.text     "content"
    t.integer  "post_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "postreplies", ["post_id"], name: "index_postreplies_on_post_id"
  add_index "postreplies", ["user_id"], name: "index_postreplies_on_user_id"

  create_table "posts", force: :cascade do |t|
    t.text     "content"
    t.text     "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
    t.integer  "forum_id"
  end

  add_index "posts", ["forum_id"], name: "index_posts_on_forum_id"
  add_index "posts", ["user_id"], name: "index_posts_on_user_id"

  create_table "ratings", force: :cascade do |t|
    t.integer  "difficulty"
    t.integer  "quality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "display_name"
    t.string   "password"
    t.string   "email"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "admin"
  end

end
