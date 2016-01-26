class ModifyTaskAttributes < ActiveRecord::Migration
  def change
    remove_column :tasks, :ended_at
    add_column :tasks, :duration, :integer # number of seconds
  end
end
