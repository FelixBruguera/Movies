class CreateApps < ActiveRecord::Migration[7.1]
  def change
    create_table :apps do |t|
        t.string :name
      end
  end
end
