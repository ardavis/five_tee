class TasksController < ApplicationController

  before_action :get_task, only: [:show, :update, :update_duration, :destroy, :complete,
                                  :start, :restart, :pause]


  def index
    respond_to do |format|
      @task = current_user.tasks.new
      @tag = Tag.new
      @incomplete_tasks = current_user.incomplete_tasks
      @completed_tasks = current_user.completed_tasks
      format.html
    end
  end

  def new_task_form
    flash[:success] = nil
    respond_to do |format|
      @task = Task.new()
      format.html
      format.js { render 'tasks/modal_scripts/new_modal.coffee.erb' }
    end
  end

  def update_duration_modal
    @task = Task.find(params[:task])
    respond_to do |format|
      format.js { render 'tasks/modal_scripts/duration_modal.coffee.erb' }
    end
  end

  def update_duration
    respond_to do |format|
      if @task.started_at
        @task.pause!
        @task.start!(current_user)
      end
      if @task.update_attributes(task_params)
        get_sorted_tasks
        format.js { render 'tasks/reload_scripts/reload_updated_duration.coffee.erb'}
        flash[:success] = "Duration succesfully edited!"
      end
    end
  end


  def show_modal
    @task = Task.find(params[:task])
    if @task.started_at
      @task.pause!
      @task.start!(current_user)
    end
    respond_to do |format|
      format.js { render 'tasks/modal_scripts/show_modal.coffee.erb' }
    end
  end


  def edit_modal
    flash[:success] = nil
    respond_to do |format|
      @task = Task.find(params[:task])
      format.js { render 'tasks/modal_scripts/edit_modal.coffee.erb' }
    end
  end

  def show
  end

  def create
    @task = current_user.tasks.new(task_params)
    respond_to do |format|
      get_sorted_tasks
      if @task.save
        @task = Task.new()
        get_sorted_tasks
        format.js { render 'tasks/reload_scripts/reload_on_create.coffee.erb'}
        flash[:success] = "Task successfully created!"
      else
        format.js {render 'tasks/reload_scripts/reload_on_fail_create.coffee.erb'
        }
      end
    end
  end


  def update
    respond_to do |format|
      if @task.update_attributes(task_params)
        get_sorted_tasks
        format.js { render 'tasks/reload_scripts/reload_on_update.coffee.erb'
        }
        flash[:success] = task_params.has_key?(:duration) ? "Duration succesfully edited!" : "Task successfully updated"
      else
        format.js {render 'tasks/reload_scripts/reload_on_fail_update.coffee.erb'
        }
      end
    end
  end


  def destroy
    respond_to do |format|
      @task.destroy
      get_sorted_tasks
      format.js { render 'tasks/reload_scripts/restart_reload.coffee.erb' }
    end
  end

  def complete
    respond_to do |format|
      @task.complete!
      get_sorted_tasks
      format.js { render 'tasks/reload_scripts/restart_reload.coffee.erb' }
    end
  end

  def start
    @task.start!(current_user)
    respond_to do |format|
      get_sorted_tasks
      format.js { render 'tasks/button_scripts/playbutton.coffee.erb' }
    end
  end

  def pause
    respond_to do |format|
      @task.pause!
      get_sorted_tasks
      format.js { render 'tasks/button_scripts/pausebutton.coffee.erb' }
    end
  end

  def download_all
    #grab all the tasks, and pass them to the ruby code in the axlsx file, gem handles everything
    @tasks = Task.all
    render xlsx: 'download.xlsx.axlsx',filename: "allTasks.xlsx"
  end

  def download_incompleted
    #grab all the tasks, and pass them to the ruby code in the axlsx file, gem handles everything
    @tasks = Task.incomplete
    render xlsx: 'download.xlsx.axlsx',filename: "incompletedTasks.xlsx"
  end

  def download_completed
    #grab all the tasks, and pass them to the ruby code in the axlsx file, gem handles everything
    @tasks = Task.completed
    render xlsx: 'download.xlsx.axlsx',filename: "completedTasks.xlsx"
  end

  def restart
    respond_to do |format|
      @task.restart!
      get_sorted_tasks
      format.js { render 'tasks/reload_scripts/restart_reload.coffee.erb' }
    end
  end


  def get_sorted_tasks
    @incomplete_tasks = current_user.incomplete_tasks
    @completed_tasks = current_user.completed_tasks
  end

  private

  def get_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :desc, :due_date, :tag_id, :duration)
  end
end
