module TasksHelper

  def incomplete_tasks
    current_user.tasks.where(completed_at: nil).order('created_at DESC')
  end

  def complete_tasks
    current_user.tasks.where.not(completed_at: nil).order('created_at DESC')
  end

  def tasks_hash
    if current_user.session.filter_tag_id
      filtered_tasks = current_user.tasks
                           .where(tag_id: current_user.session.filter_tag_id)
                           .order(current_user.session.sort_sql)
    else
      filtered_tasks = current_user.tasks
                           .order(current_user.session.sort_sql)
    end
    {
        incomplete: filtered_tasks.where(completed_at: nil).where(archive_id: nil).map{|task| react_task(task)},
        complete: filtered_tasks.where.not(completed_at: nil).where(archive_id: nil).map{|task| react_task(task)}
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
    json['finished_display'] = task.completed_at ? finished_display(task.completed_at) : nil
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

  def finished_display(completed)
    duration = (Time.now - completed).to_i
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

  def fix_date(date)
    return nil if date.blank?
    fixed_date = date[3..5]
    fixed_date << date[0..2]
    fixed_date << date[6..9]
  end

  def filtered_tasks_list
    if current_user.session.filter_tag_id and current_user.session.filter_tag_id != 0
      current_user.tasks.where(tag_id: current_user.session.filter_tag_id)
    else
      current_user.tasks
    end
  end

  def due_date_display(task)
    task.due_date ? task.due_date.strftime('%m/%d/%Y') : ''
  end

  def tag_display(task)
    task.tag ? task.tag.name : ''
  end

end
