class FixAppMoviesColumn < ActiveRecord::Migration[7.1]
  def change
    rename_column :app_movies, :actor_id, :app_id
  end
end
