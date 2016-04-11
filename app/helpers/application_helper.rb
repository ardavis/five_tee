module ApplicationHelper

  def filter_tag_label
    tag_id = current_user.session.filter_tag_id
    tag_id ? Tag.find(tag_id).name : 'All Tags'
  end

  def sort_label
    sql = current_user.session.sort_sql
    sort_options.each { |option| return option[:label] if option[:sql] == sql }
    return 'Alphabetical'
  end

  def react_tags_hash
    react_tags = current_user.tags.all.map{|tag| {name: tag.name, id: tag.id}}
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
        due_date: task.due_date,
        completed_at: task.completed_at.to_i,
        started_at: task.started_at.to_i,
        running: !!task.started_at,
        created_at: task.created_at.to_i,
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
        filter_sort: react_filter_sort_hash
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

end
