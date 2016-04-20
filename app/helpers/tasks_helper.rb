module TasksHelper

  def incomplete_tasks
    current_user.tasks.where(completed_at: nil)
  end

  def complete_tasks
    current_user.tasks.where.not(completed_at: nil)
  end

  def tasks_hash
    {
        incomplete: incomplete_tasks.map{|task| react_task(task)},
        complete: complete_tasks.map{|task| react_task(task)}
    }
  end

  def react_task(task)
    json = task.as_json
    json['started_at'] = json['started_at'] ? json['started_at'].to_i : nil
    json['completed_at'] = json['completed_at'] ? json['completed_at'].to_i : nil
    puts json
    json
  end

end
