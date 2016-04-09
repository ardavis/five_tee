module ApplicationHelper

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

end
