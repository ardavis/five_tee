class AddTagToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :tag_id, :integer
  end
end
