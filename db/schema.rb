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

ActiveRecord::Schema.define(version: 2020_11_16_170216) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string "type_address"
    t.string "status"
    t.string "entite"
    t.string "address"
    t.string "address2"
    t.string "city"
    t.string "postal_code"
    t.string "country"
    t.text "notes"
    t.float "latitude"
    t.float "longitude"
    t.string "full_street_address"
  end

  create_table "batteries", force: :cascade do |t|
    t.string "type_building"
    t.string "status"
    t.date "date_commissioning"
    t.date "date_last_inspection"
    t.string "cert_ope"
    t.string "information"
    t.text "notes"
    t.bigint "building_id"
    t.bigint "employee_id"
    t.index ["building_id"], name: "index_batteries_on_building_id"
    t.index ["employee_id"], name: "index_batteries_on_employee_id"
  end

  create_table "buildings", force: :cascade do |t|
    t.string "adm_contact_name"
    t.string "adm_contact_mail"
    t.string "adm_contact_phone"
    t.string "tect_contact_name"
    t.string "tect_contact_email"
    t.string "tect_contact_phone"
    t.bigint "customer_id"
    t.bigint "address_id"
    t.index ["address_id"], name: "index_buildings_on_address_id"
    t.index ["customer_id"], name: "index_buildings_on_customer_id"
  end

  create_table "buildings_details", force: :cascade do |t|
    t.string "info_key"
    t.string "value"
    t.bigint "building_id"
    t.index ["building_id"], name: "index_buildings_details_on_building_id"
  end

  create_table "columns", force: :cascade do |t|
    t.string "type_building"
    t.integer "amount_floors_served"
    t.string "status"
    t.string "information"
    t.text "notes"
    t.bigint "battery_id"
    t.index ["battery_id"], name: "index_columns_on_battery_id"
  end

  create_table "customers", force: :cascade do |t|
    t.date "date_create"
    t.string "company_name"
    t.string "cpy_contact_name"
    t.string "cpy_contact_phone"
    t.string "cpy_contact_email"
    t.string "cpy_description"
    t.string "sta_name"
    t.string "sta_phone"
    t.string "sta_mail"
    t.bigint "user_id"
    t.bigint "address_id"
    t.index ["address_id"], name: "index_customers_on_address_id"
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "dim_customers", force: :cascade do |t|
    t.date "creation_date"
    t.string "company_name"
    t.string "cpy_contact_name"
    t.string "cpy_contact_email"
    t.integer "amount_elevator"
    t.string "customer_city"
  end

  create_table "elevators", force: :cascade do |t|
    t.string "serial_number"
    t.string "model"
    t.string "type_building"
    t.string "status"
    t.date "date_commissioning"
    t.date "date_last_inspection"
    t.string "cert_ope"
    t.string "information"
    t.text "notes"
    t.bigint "column_id"
    t.index ["column_id"], name: "index_elevators_on_column_id"
  end

  create_table "employees", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_employees_on_user_id"
  end

  create_table "fact_contacts", force: :cascade do |t|
    t.integer "contact_id"
    t.date "creation_date"
    t.string "company_name"
    t.string "email"
    t.string "project_name"
  end

  create_table "fact_elevators", force: :cascade do |t|
    t.string "serial_number"
    t.date "commissioning_date"
    t.string "building_id"
    t.string "customer_id"
    t.string "building_city"
  end

  create_table "fact_intervention", force: :cascade do |t|
    t.integer "employee_id"
    t.integer "building_id"
    t.integer "battery_id"
    t.integer "column_id"
    t.integer "elevator_id"
    t.datetime "start_date_intervention"
    t.datetime "end_date_intervention"
    t.string "result"
    t.text "report"
    t.string "status"
  end

  create_table "fact_quotes", force: :cascade do |t|
    t.integer "quote_id"
    t.date "creation_date"
    t.string "company_name"
    t.string "email"
    t.integer "amount_elevator"
  end

  create_table "interventions", force: :cascade do |t|
    t.date "startDateIntervention"
    t.date "endDateIntervention"
    t.string "result", default: "Incomplete"
    t.string "report"
    t.string "status", default: "Pending"
    t.bigint "author_id"
    t.bigint "customer_id"
    t.bigint "building_id"
    t.bigint "battery_id"
    t.bigint "column_id"
    t.bigint "elevator_id"
    t.bigint "employee_id"
    t.index ["author_id"], name: "index_interventions_on_author_id"
    t.index ["battery_id"], name: "index_interventions_on_battery_id"
    t.index ["building_id"], name: "index_interventions_on_building_id"
    t.index ["column_id"], name: "index_interventions_on_column_id"
    t.index ["customer_id"], name: "index_interventions_on_customer_id"
    t.index ["elevator_id"], name: "index_interventions_on_elevator_id"
    t.index ["employee_id"], name: "index_interventions_on_employee_id"
  end

  create_table "leads", force: :cascade do |t|
    t.string "full_name"
    t.string "company_name"
    t.string "email"
    t.string "phone_number"
    t.string "project_name"
    t.string "project_description"
    t.string "department"
    t.text "message"
    t.binary "attached_file"
    t.date "create_at"
    t.bigint "customer_id"
    t.string "name_attached_file"
    t.index ["customer_id"], name: "index_leads_on_customer_id"
  end

  create_table "quotes", force: :cascade do |t|
    t.string "company_name"
    t.string "building_type"
    t.integer "apps_qty"
    t.integer "floors_qty"
    t.integer "basements_qty"
    t.integer "parkings_qty"
    t.integer "elevators_qty"
    t.integer "business_qty"
    t.integer "occupants_floors_qty"
    t.integer "hours_activity"
    t.string "game"
    t.integer "elevator_needed"
    t.integer "total_price"
    t.string "email"
    t.date "create_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "batteries", "buildings"
  add_foreign_key "batteries", "employees"
  add_foreign_key "buildings", "addresses"
  add_foreign_key "buildings", "customers"
  add_foreign_key "buildings_details", "buildings"
  add_foreign_key "columns", "batteries"
  add_foreign_key "customers", "addresses"
  add_foreign_key "customers", "users"
  add_foreign_key "elevators", "columns"
  add_foreign_key "employees", "users"
  add_foreign_key "interventions", "batteries"
  add_foreign_key "interventions", "buildings"
  add_foreign_key "interventions", "columns"
  add_foreign_key "interventions", "customers"
  add_foreign_key "interventions", "elevators"
  add_foreign_key "interventions", "employees"
  add_foreign_key "interventions", "employees", column: "author_id"
  add_foreign_key "leads", "customers"
end
