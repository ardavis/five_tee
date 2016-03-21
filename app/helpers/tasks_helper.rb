module TasksHelper

  def duration_display(duration)
    return "Not started" unless duration
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

end
