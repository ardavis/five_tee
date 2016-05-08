module TasksHelper

  def incomplete_tasks
    current_user.tasks.where(completed_at: nil).order('created_at DESC')
  end

  def complete_tasks
    current_user.tasks.where.not(completed_at: nil).order('created_at DESC')
  end

  def tasks_hash(tasks=current_user.tasks.all)
    @incomplete_tasks = tasks.where(completed_at: nil)
    @complete_tasks = tasks.where.not(completed_at: nil)
    {
        incomplete: @incomplete_tasks.map{|task| react_task(task)},
        complete: @complete_tasks.map{|task| react_task(task)}
    }
  end

  def react_task(task)
    json = task.as_json
    json['started_at'] = json['started_at'] ? json['started_at'].to_i : nil
    json['due_date'] = json['due_date'] ? json['due_date'].strftime('%m-%d-%Y') : nil
    json['created_at'] = json['created_at'] ? json['created_at'].strftime('%m-%d-%Y') : nil
    json['completed_at_display'] = json['completed_at'] ? json['completed_at'].strftime('%m-%d-%Y') : nil
    json['completed_at'] = json['completed_at'] ? json['completed_at'].to_i : nil
    json['duration_display'] = duration_display(task.duration)
    if task.tag
      json['tag'] = {'id' => task.tag.id, 'name' => task.tag.name}
    end
    json
  end

  def duration_display(duration)
    return 'Not started' unless duration
    duration_string = "#{duration % 60} sec"
    duration_string.prepend '0' unless duration < 60 or duration % 60 > 9
    duration_string.prepend "#{duration / 60 % 60} min "
    duration_string.prepend '0' unless duration < 3600 or duration / 60 % 60 > 9
    duration_string.prepend "#{duration / 3600} hr "
  end

  def fix_date(date)
    return nil if date.blank?
    fixed_date = date[3..5]
    fixed_date << date[0..2]
    fixed_date << date[6..9]
  end

end
