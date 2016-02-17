module TasksHelper

  def show_pause_button?(task)
    task.started_at.nil? ? 'hide' : ''
  end

  def show_play_button?(task)
    task.started_at ? 'hide' : ''
  end

end