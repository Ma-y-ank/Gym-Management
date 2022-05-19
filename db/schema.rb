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

ActiveRecord::Schema[7.0].define(version: 2022_05_04_061950) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diets", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "exercise_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["exercise_id"], name: "index_diets_on_exercise_id"
  end

  create_table "exercises", force: :cascade do |t|
    t.string "name", null: false
    t.text "description", null: false
    t.string "category", null: false
    t.string "link", null: false
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "user_exercises", force: :cascade do |t|
    t.integer "user_id"
    t.integer "exercise_id"
    t.boolean "favourite", default: false
    t.boolean "completed", default: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.integer "trainer_id"
    t.string "role", default: "Trainee"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at", precision: nil
    t.datetime "remember_created_at", precision: nil
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["trainer_id"], name: "index_users_on_trainer_id"
  end

  add_foreign_key "diets", "exercises"
end
