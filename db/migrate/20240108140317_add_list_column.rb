class AddListColumn < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :list, :string
  end
end
