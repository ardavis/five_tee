class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :desc
      t.datetime :due_date
      t.datetime :completed_at
      t.datetime :started_at
      t.datetime :ended_at

      t.timestamps null: false
    end
  end
end
