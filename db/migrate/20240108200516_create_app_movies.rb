class CreateAppMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :app_movies do |t|
      t.belongs_to :actor
      t.belongs_to :movie
      t.string :link
    end
  end
end
