class AddArchiveTagToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :archive_tag, :string
  end
end
