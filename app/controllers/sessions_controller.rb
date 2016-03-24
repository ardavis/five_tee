class SessionsController < Devise::SessionsController

  before_action :session_init, only: [:create]

  before_action :update_filter_sort, only: [:update]

  def session_init
    current_user.session.destroy if current_user.session
    @session = Session.create(user_id: current_user.id)
    current_user.update_attributes(session_id: @session.id)
  end

  def update_filter_sort
    current_user.session.update_attributes(session_params)
    current_user.session.update_attributes(filter_tag_id: nil) if session_params[:filter_tag_id] == '0'
    call_coffeescript('tasks/reload_scripts/restart_reload.coffee.erb')
  end


  private

  def session_params
    @incomplete_tasks = current_user.incomplete_tasks
    @completed_tasks = current_user.completed_tasks
    params.permit(:filter_tag_id, :sort_sql)
  end
end