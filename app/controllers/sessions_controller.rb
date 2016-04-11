class SessionsController < Devise::SessionsController

  include ApplicationHelper

  before_action :session_init, only: [:create]

  before_action :update_filter_sort, only: [:update]

  before_action :get_sorted_tasks, only: [:session_params, :update_filter_sort]

  def session_init
    if current_user
      current_user.session.destroy if current_user.session
      @session = Session.create(user_id: current_user.id)
      current_user.update_attributes(session_id: @session.id)
    end
  end

  def react_json
    respond_to do |format|
      format.json { render json: react_payload}
    end
  end


  def update_filter_sort
    current_user.session.update_attributes(session_params)
    if ['0', 'undefined'].include? session_params[:filter_tag_id]
      current_user.session.update_attributes(filter_tag_id: nil)
    end
    react_json
  end


  private



  def session_params
    params.permit(:filter_tag_id, :sort_sql)
  end
end