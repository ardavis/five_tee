module ApplicationHelper

  def filter_tag_label
    tag_id = current_user.session.filter_tag_id
    tag_id ? Tag.find(tag_id).name : 'All Tags'
  end

  def sort_label
    sql = current_user.session.sort_sql
    label = 'Alphabetical'
    sort_options.to_a.each { |option| label = option[:label] if option[:sql] == sql }
    label
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

  def react_tags_hash
    react_tags = current_user.tags.all.map{|tag| {name: tag.name, id: tag.id}}
  end

  def react_tag(tag)
    {name: tag.name, id: tag.id}
  end

  def react_filter_sort_hash
    tag_id = current_user.session.filter_tag_id
    sort_sql = current_user.session.sort_sql
    react_filter_sort = {
        filter: {id: tag_id, label: filter_tag_label},
        sort: {sql: sort_sql, label: sort_label}
    }
  end

  def react_task(task)
    react_task_hash = {
        id: task.id,
        title: task.title,
        desc: task.desc,
        due_date: task.due_date ? task.due_date.strftime('%m-%d-%Y') : nil,
        created_at: task.created_at.to_i,
        created_at_show: task.created_at.strftime('%m-%d-%Y'),
        tag: task.tag ? task.tag.name : nil,
        tag_id: task.tag ? task.tag.id : nil,
        completed_at: task.completed_at.to_i,
        completed_at_show: task.completed_at ? task.completed_at.strftime('%m-%d-%Y') : nil,
        started_at: task.started_at.to_i,
        running: !!task.started_at,
        duration: task.duration,
        duration_display: duration_display(task.duration),
        finished_display: task.completed_at ? finished_display(task.completed_at) : nil
    }
  end

  def react_tasks(tasks)
    filtered_sorted_tasks(tasks).map{|task| react_task(task)}
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

  def react_payload
    payload = {
        tasks: react_tasks_hash,
        tags: react_tags_hash,
        show_task: nil,
        selected_task: nil,
        filter_sort: react_filter_sort_hash,
        sort_options: sort_options,
        flash: nil
    }
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

end
