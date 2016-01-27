class Task < ActiveRecord::Base
  validates :title, presence: true

  scope :incomplete, -> { where(completed_at: nil) }
  scope :completed, -> { where.not(completed_at: nil) }
  scope :running, -> { where.not(started_at: nil) }

  # This method completes a task by setting the completed_at date
  def complete!
    update_attributes(completed_at: Time.now)
    pause! if Task.running.exists?(self)
  end

  # This method starts the task!
  def start!
    # Pause any previously running tasks
    Task.running.each do |running_task|
      running_task.pause!
    end

    # Start the clock on this task
    update_attributes(started_at: Time.now)
  end

  # This method restarts the task
  def restart!
    update_attributes(completed_at: nil)
  end

  # This method pauses the task!
  def pause!
    # Add the difference of Time.now and started_at
    # to the duration
    difference = Time.now.to_i - self.started_at.to_i

    # Set the started_at to nil also, only the running task should have
    # that set.
    update_attributes(duration: duration.to_i + difference, started_at: nil)
  end

end
