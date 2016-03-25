class AddArchiveIdToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :archive_id, :integer
  end
end
