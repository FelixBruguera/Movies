class CreateActorMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :actormovies do |t|
      t.belongs_to :actor
      t.belongs_to :movie
      t.timestamps
    end
  end
end
