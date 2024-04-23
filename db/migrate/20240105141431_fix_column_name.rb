class FixColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :movies, :type, :is_tv
  end
end
