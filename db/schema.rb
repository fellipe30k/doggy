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

ActiveRecord::Schema[8.0].define(version: 2025_08_08_124434) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "animals", force: :cascade do |t|
    t.string "name"
    t.string "species"
    t.string "breed"
    t.date "birth_date"
    t.decimal "weight"
    t.string "color"
    t.string "microchip"
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.string "owner_name"
    t.string "owner_phone"
    t.string "owner_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "owner_id", null: false
    t.index ["company_id"], name: "index_animals_on_company_id"
    t.index ["owner_id"], name: "index_animals_on_owner_id"
    t.index ["user_id"], name: "index_animals_on_user_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.text "address"
    t.string "phone"
    t.string "email"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "owners", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone"
    t.bigint "user_id", null: true
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_owners_on_company_id"
    t.index ["user_id"], name: "index_owners_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "role"
    t.bigint "company_id"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.boolean "active"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "vaccinations", force: :cascade do |t|
    t.bigint "animal_id", null: false
    t.string "vaccine_name"
    t.string "vaccine_brand"
    t.date "application_date"
    t.date "next_dose_date"
    t.string "veterinarian_name"
    t.string "batch_number"
    t.text "observations"
    t.bigint "user_id", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["animal_id"], name: "index_vaccinations_on_animal_id"
    t.index ["company_id"], name: "index_vaccinations_on_company_id"
    t.index ["user_id"], name: "index_vaccinations_on_user_id"
  end

  add_foreign_key "animals", "companies"
  add_foreign_key "animals", "owners"
  add_foreign_key "animals", "users"
  add_foreign_key "owners", "companies"
  add_foreign_key "owners", "users"
  add_foreign_key "vaccinations", "animals"
  add_foreign_key "vaccinations", "companies"
  add_foreign_key "vaccinations", "users"
end
