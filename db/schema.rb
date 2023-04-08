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

ActiveRecord::Schema[7.0].define(version: 2023_04_08_115445) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["provider", "uid"], name: "index_authentications_on_provider_and_uid"
    t.index ["user_id"], name: "index_authentications_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.string "body", null: false
    t.bigint "user_id"
    t.bigint "fish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fish_id"], name: "index_comments_on_fish_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "fishes", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "image"
    t.datetime "fishing_date", null: false
    t.string "body", null: false
    t.decimal "latitude", precision: 11, scale: 8, null: false
    t.decimal "longitude", precision: 11, scale: 8, null: false
    t.bigint "species_id", null: false
    t.integer "size"
    t.integer "weather", limit: 2, null: false
    t.integer "wind_direction", limit: 2, null: false
    t.decimal "wind_speed", precision: 5, scale: 2, null: false
    t.decimal "temperature", precision: 5, scale: 2, null: false
    t.integer "tide_name", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["species_id"], name: "index_fishes_on_species_id"
    t.index ["user_id"], name: "index_fishes_on_user_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "follow_id"
    t.bigint "follower_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["follow_id", "follower_id"], name: "index_follows_on_follow_id_and_follower_id", unique: true
    t.index ["follow_id"], name: "index_follows_on_follow_id"
    t.index ["follower_id"], name: "index_follows_on_follower_id"
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "fish_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fish_id"], name: "index_likes_on_fish_id"
    t.index ["user_id", "fish_id"], name: "index_likes_on_user_id_and_fish_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "visitor_id", null: false
    t.integer "visited_id", null: false
    t.integer "fish_id"
    t.integer "comment_id"
    t.string "action", default: "", null: false
    t.boolean "checked", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["comment_id"], name: "index_notifications_on_comment_id"
    t.index ["fish_id"], name: "index_notifications_on_fish_id"
    t.index ["visited_id"], name: "index_notifications_on_visited_id"
    t.index ["visitor_id"], name: "index_notifications_on_visitor_id"
  end

  create_table "species", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_species_on_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.string "name", null: false
    t.string "introduction"
    t.boolean "is_published", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "avatar"
    t.string "reset_password_token"
    t.datetime "reset_password_token_expires_at"
    t.datetime "reset_password_email_sent_at"
    t.integer "access_count_to_reset_password_page", default: 0
    t.string "uuid"
    t.integer "grade", limit: 2, default: 1, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
  end

  add_foreign_key "comments", "fishes"
  add_foreign_key "comments", "users"
  add_foreign_key "follows", "users", column: "follow_id"
  add_foreign_key "follows", "users", column: "follower_id"
  add_foreign_key "likes", "fishes"
  add_foreign_key "likes", "users"
end
