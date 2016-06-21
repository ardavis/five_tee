class Task < ActiveRecord::Base
  belongs_to :tag
  belongs_to :user

  validates :title, presence: true, uniqueness: {scope: :archive_id}
  validates :desc, length: {maximum: 1000}

  scope :incomplete, -> { where(completed_at: nil) }
  scope :completed, -> { where.not(completed_at: nil) }
  scope :running, -> { where.not(started_at: nil) }

  def react_task
    json = self.as_json
    json['started_at'] = json['started_at'] ? json['started_at'].to_i : nil
    json['due_date'] = json['due_date'] ? json['due_date'].strftime('%m-%d-%Y') : nil
    json['created_at'] = json['created_at'] ? json['created_at'].strftime('%m-%d-%Y') : nil
    json['completed_at_display'] = json['completed_at'] ? json['completed_at'].strftime('%m-%d-%Y') : nil
    json['completed_at'] = json['completed_at'] ? json['completed_at'].to_i : nil
    json['duration_display'] = self.duration_display
    json['finished_display'] = self.completed_at ? self.finished_display : nil
    if self.tag
      json['tag'] = {'id' => self.tag.id, 'name' => self.tag.name}
    end
    json
  end

  def duration_display
    return 'Not started' unless duration
    duration_string = "#{duration % 60} sec"
    duration_string.prepend '0' unless duration < 60 or duration % 60 > 9
    duration_string.prepend "#{duration / 60 % 60} min "
    duration_string.prepend '0' unless duration < 3600 or duration / 60 % 60 > 9
    duration_string.prepend "#{duration / 3600} hr "
  end

  def finished_display
    duration = (Time.now - completed_at).to_i
    if duration < 2
      return "just now"
    elsif duration < 60
      return "Less than 1 min ago"
    elsif duration < 3600
      return "#{(duration / 60).to_i} min ago"
    else
      "#{duration / 3600} hr #{duration / 60 % 60} min ago"
    end
  end

  def due_date_display
    due_date ? due_date.strftime('%m/%d/%Y') : ''
  end

  def tag_display
    tag ? tag.name : ''
  end

  # This method completes a task by setting the completed_at date
  def complete!
    update_attributes(completed_at: Time.now)
    pause! if running?
  end

  def running?
    !started_at.nil?
  end

  # This method starts the task!
  def start!(user)
    # Pause any previously running tasks
    user.tasks.running.each do |running_task|
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
