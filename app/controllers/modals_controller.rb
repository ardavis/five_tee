class ModalsController < TasksController

  before_action :get_task, only: [:new_task_modal, :show_task_modal, :edit_task_modal, :update_duration_modal]
  before_action :reset_flash, only: [:new_task_modal, :show_task_modal, :edit_task_modal, :update_duration_modal]

  def new_task_modal
    call_coffeescript('tasks/modal_scripts/new_modal.coffee.erb')
  end

  def show_task_modal
    if @task.started_at
      @task.pause!
      @task.start!(current_user)
    end
    call_coffeescript('tasks/modal_scripts/show_modal.coffee.erb')
  end

  def edit_task_modal
    call_coffeescript('tasks/modal_scripts/edit_modal.coffee.erb')
  end

  def update_duration_modal
    call_coffeescript('tasks/modal_scripts/duration_modal.coffee.erb')
  end

  def new_tag_modal
    @tag = current_user.tags.new()
    @task = params[:task].present? ? Task.find(params[:task].to_i) : Task.new()
    flash[:success] = nil
    call_coffeescript('tags/modal_scripts/new_tag_modal.coffee.erb')
  end

  def manage_tag_modal
    call_coffeescript('tags/modal_scripts/manage_tag_modal.coffee.erb')
  end

end
