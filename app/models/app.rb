class App < ApplicationRecord
    has_many :app_movies
    has_many :movies, through: :app_movies
end
