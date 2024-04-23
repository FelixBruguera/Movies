class FixJoinTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :actors_movies
    create_table :actormovies, id:false do |t|
      t.belongs_to :actor
      t.belongs_to :movie
    end
  end
end
