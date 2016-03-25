class RemoveTagNameFromTask < ActiveRecord::Migration
  def change
    remove_column :tasks, :tag_name, :string
  end
end
