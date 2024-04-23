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

ActiveRecord::Schema[7.1].define(version: 2024_01_08_201115) do
  create_table "actor_movies", force: :cascade do |t|
    t.integer "actor_id"
    t.integer "movie_id"
    t.index ["actor_id"], name: "index_actor_movies_on_actor_id"
    t.index ["movie_id"], name: "index_actor_movies_on_movie_id"
  end

  create_table "actormovie", force: :cascade do |t|
    t.integer "actor_id"
    t.integer "movie_id"
    t.index ["actor_id"], name: "index_actormovie_on_actor_id"
    t.index ["movie_id"], name: "index_actormovie_on_movie_id"
  end

  create_table "actors", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "actors_movies", id: false, force: :cascade do |t|
    t.integer "actor_id"
    t.integer "movie_id"
    t.index ["actor_id"], name: "index_actors_movies_on_actor_id"
    t.index ["movie_id"], name: "index_actors_movies_on_movie_id"
  end

  create_table "app_movies", force: :cascade do |t|
    t.integer "app_id"
    t.integer "movie_id"
    t.string "link"
    t.index ["app_id"], name: "index_app_movies_on_app_id"
    t.index ["movie_id"], name: "index_app_movies_on_movie_id"
  end

  create_table "apps", force: :cascade do |t|
    t.string "name"
  end

  create_table "movies", force: :cascade do |t|
    t.string "movie_id"
    t.string "title"
    t.string "image"
    t.integer "year"
    t.float "rating"
    t.integer "episodes"
    t.string "genre"
    t.text "plot"
    t.text "availability"
    t.text "cast"
    t.boolean "is_tv"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "list"
  end

end
