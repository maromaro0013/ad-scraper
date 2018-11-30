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

ActiveRecord::Schema.define(version: 2018_11_30_115355) do

  create_table "ads", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.text "ad_link"
    t.text "img_link"
    t.string "title"
    t.string "company_name"
    t.bigint "target_site_id", null: false
    t.bigint "target_page_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_page_id"], name: "index_ads_on_target_page_id"
    t.index ["target_site_id"], name: "index_ads_on_target_site_id"
  end

  create_table "crawl_methods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "target_page_crawl_methods", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.bigint "target_page_id", null: false
    t.bigint "crawl_method_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["crawl_method_id"], name: "index_target_page_crawl_methods_on_crawl_method_id"
    t.index ["target_page_id"], name: "index_target_page_crawl_methods_on_target_page_id"
  end

  create_table "target_pages", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "uri", null: false
    t.bigint "target_site_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["target_site_id"], name: "index_target_pages_on_target_site_id"
  end

  create_table "target_sites", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "name", null: false
    t.string "domain", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ads", "target_pages"
  add_foreign_key "ads", "target_sites"
  add_foreign_key "target_page_crawl_methods", "crawl_methods"
  add_foreign_key "target_page_crawl_methods", "target_pages"
  add_foreign_key "target_pages", "target_sites"
end
