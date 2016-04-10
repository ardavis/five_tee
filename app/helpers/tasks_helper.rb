module TasksHelper

  def filter_tag_label
    tag_id = current_user.session.filter_tag_id
    tag_id ? Tag.find(tag_id).name : 'All Tags'
  end

  def filtered_sorted_tasks(tasks)
    id = current_user.session.filter_tag_id
    filtered_tasks = id ? tasks.where(tag_id: id) : tasks
    if current_user.session.sort_sql.include? 'due_date'
      missing_due_dates = filtered_tasks.where(due_date: nil)
      have_due_dates = filtered_tasks.where.not(due_date: nil)
      filtered_tasks = have_due_dates.order(current_user.session.sort_sql) + missing_due_dates.order('lower(title) ASC')
    else
      filtered_tasks.order(current_user.session.sort_sql)
    end
  end

  def sort_label
    sql = current_user.session.sort_sql
    sort_options.each { |option| return option[:label] if option[:sql] == sql }
    return 'Alphabetical'
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
      return 'just now'
    elsif duration < 60
      return 'Less than 1 min ago'
    elsif duration < 3600
      return "#{(duration / 60).to_i} min ago"
    else
      "#{duration / 3600} hr #{duration / 60 % 60} min ago"
    end
  end

  def show_flash_for(partial)
    return false if flash[:success].to_s == ''
    flash_array = flash[:success].to_s.split(' ')
    if partial == 'task_form'
      return true if flash_array.include? 'Task'
      return true if flash_array.include? 'Duration'
      return true if flash_array.include? 'Tag'
    elsif partial == 'tag_form'
      return true if flash_array.include? 'Tag'
    end
    false
  end

  def tag_dropdown_options
    list = [['Create new tag', nil]]
    current_user.tags.order('name ASC').each {|t| list << [t.name, t.id]}
    list
  end

  def sort_options
    list = []
    list << {label: 'Alphabetical', sql: 'lower(title) ASC'}
    list << {label: 'Newest to Oldest', sql: 'created_at DESC'}
    list << {label: 'Oldest to Newest', sql: 'created_at ASC'}
    list << {label: 'Shortest Duration', sql: 'duration ASC'}
    list << {label: 'Longest Duration', sql: 'duration DESC'}
    list << {label: 'Due soonest', sql: 'due_date ASC'}
    list << {label: 'Due latest', sql: 'due_date DESC'}
  end

  def tasks_in(archive)
    current_user.tasks.where(archive_id: archive.id)
  end

  def only(type, tasks)
    if type == 'complete'
      tasks.to_a.delete_if{|t| t.completed_at.blank?}
    elsif type == 'incomplete'
      tasks.to_a.delete_if{|t| t.completed_at}
    end
  end


  def react_task(task)
    react_task_hash = {
        id: task.id,
        title: task.title,
        desc: task.desc,
        due_date: task.due_date,
        completed_at: task.completed_at.to_i,
        started_at: task.started_at.to_i,
        created_at: task.created_at.to_i,
        duration: task.duration,
        duration_display: duration_display(task.duration),
        finished_display: task.completed_at ? finished_display(task.completed_at) : nil
    }
  end

  def react_tasks(tasks)
    tasks.map{|task| react_task(task)}
  end


  def incomplete_tasks
    current_user.tasks.where(completed_at: nil)
  end

  def complete_tasks
    current_user.tasks.where.not(completed_at: nil)
  end

  def react_tasks_hash
    {incomplete: react_tasks(incomplete_tasks), complete: react_tasks(complete_tasks)}
  end

end
