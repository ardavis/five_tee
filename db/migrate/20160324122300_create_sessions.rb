class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :user_id
      t.integer :filter_tag_id
      t.string :sort_sql

      t.timestamps null: false
    end
  end
end
