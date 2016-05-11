class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :authenticate_user!


  def filtered_tasks
    if current_user.session.filter_tag_id and current_user.session.filter_tag_id != 0
      current_user.tasks.where(tag_id: current_user.session.filter_tag_id)
    else
      current_user.tasks
    end
  end

  def mid_string(string, start, fin)
    byebug
    string[/#{Regexp.escape(start)}(.*?)#{Regexp.escape(fin)}/m, 1]
  end

end
