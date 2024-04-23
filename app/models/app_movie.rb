class AppMovie < ApplicationRecord
    belongs_to :app
    belongs_to :movie
end
