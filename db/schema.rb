# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120229145724) do

  create_table "contents", :force => true do |t|
    t.string   "title_en"
    t.text     "text_en"
    t.string   "symbol"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title_es"
    t.text     "text_es"
    t.string   "title_fr"
    t.text     "text_fr"
    t.string   "page_title_fr"
    t.string   "page_description_fr"
    t.string   "page_title_es"
    t.string   "page_description_es"
    t.string   "page_title_en"
    t.string   "page_description_en"
  end

  create_table "invitations", :force => true do |t|
    t.string   "code"
    t.text     "comment"
    t.integer  "nb_connections", :default => 0
    t.integer  "nb_pages_seen",  :default => 0
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "is_admin"
  end

  create_table "picture_categories", :force => true do |t|
    t.string  "name_en"
    t.integer "position",   :default => 0
    t.string  "name_es"
    t.string  "name_fr"
    t.string  "symbol"
    t.boolean "in_gallery"
  end

  create_table "pictures", :force => true do |t|
    t.string  "photo_file_name"
    t.string  "photo_content_type"
    t.integer "photo_file_size"
    t.integer "picture_category_id"
    t.string  "comment_en"
    t.string  "comment_es"
    t.string  "comment_fr"
  end

end
