class Archive < ActiveRecord::Base
  belongs_to :user
  validates :user_id, presence: true


  def archive_tasks_hash
    {
        incomplete: self.user.filtered_tasks.where(completed_at: nil)
                        .where(archive_id: self.id)
                        .order('created_at ASC')
                        .map{|task| task.react_task},

        complete: self.user.filtered_tasks.where.not(completed_at: nil)
                      .where(archive_id: self.id)
                      .order('created_at ASC')
                      .map{|task| task.react_task}
    }
  end

end
