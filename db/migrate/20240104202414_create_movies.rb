class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :movie_id
      t.string :title
      t.string :image
      t.integer :year
      t.float :rating
      t.integer :episodes
      t.string :genre
      t.text :plot
      t.string :availability
      t.string :cast
      t.string :is_tv
      t.timestamps
    end
  end
end
