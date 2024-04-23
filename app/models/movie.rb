require 'rest-client'

class Movie < ApplicationRecord
    has_many :actors_movies
    has_many :actors, through: :actor_movies
    has_many :app_movies
    has_many :apss, through: :app_movies
    serialize :availability, coder: JSON
    serialize :cast, coder: JSON
end
