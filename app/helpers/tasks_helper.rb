module TasksHelper

  def duration_display(duration)
    return "#{duration / 60} min #{duration % 60} sec" if duration < 59
    "#{duration / 60} min #{duration % 60 < 10 ? '0' : ''}#{duration % 60} sec"
  end
end