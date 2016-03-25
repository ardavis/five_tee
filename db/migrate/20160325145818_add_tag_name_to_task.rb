class AddTagNameToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :tag_name, :string
  end
end
