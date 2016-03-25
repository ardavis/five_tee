class AddUserIdToArchive < ActiveRecord::Migration
  def change
    add_column :archives, :user_id, :integer
  end
end
