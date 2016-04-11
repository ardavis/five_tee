module TasksHelper



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




end
