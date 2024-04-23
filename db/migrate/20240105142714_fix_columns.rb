class FixColumns < ActiveRecord::Migration[7.1]
  def change
    change_column(:movies, :availability, :text)
    change_column(:movies, :cast, :text)
    change_column(:movies, :is_tv, :boolean)
  end
end
