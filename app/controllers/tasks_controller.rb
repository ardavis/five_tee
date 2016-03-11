class TasksController < ApplicationController

  before_action :get_task, only: [:show, :update, :destroy, :complete,
                                  :start, :restart, :pause]


  def index
    respond_to do |format|
      @task = current_user.tasks.new
      @tag = Tag.new
      @incomplete_tasks = current_user.incomplete_tasks
      @completed_tasks = current_user.completed_tasks
      format.html
      format.js { render 'playbutton.js.coffee.erb' }
    end
  end

  def new_task_form
    respond_to do |format|
      @task = Task.new()
      format.html
      format.js { render 'new.js.coffee.erb' }
    end
  end


  def select
    @task = Task.find(params[:task])
    respond_to do |format|
      format.html
      format.js { render 'select.js.erb' }
    end
  end


  def edit
    @task = Task.find(params[:task])
    flash[:success] = nil
    respond_to do |format|
      format.html
      format.js { render 'edit.js.erb' }
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
        format.js { render 'reload_on_create.js.erb'}
        flash[:success] = "Task successfully created!"
      else
        format.js {render 'reload_on_fail_create.js.erb'}
      end
    end
  end


  def update
    respond_to do |format|
      if @task.update_attributes(task_params)
        flash[:success] = "Task successfully edited!"
        get_sorted_tasks
        format.js { render 'reload_on_update.js.erb'}
      else
        format.js {render 'reload_on_fail_update.js.erb'}
      end
    end
  end


  def destroy
    respond_to do |format|
      @task.destroy
      get_sorted_tasks
      format.js { render 'restart_reload.js.coffee.erb' }
    end
  end

  def complete
    respond_to do |format|
      @task.complete!
      get_sorted_tasks
      format.js { render 'restart_reload.js.coffee.erb' }
    end
  end

  def start
    @task.start!(current_user)
    respond_to do |format|
      get_sorted_tasks
      format.js { render 'playbutton.js.coffee.erb' }
    end
  end

  def pause
    respond_to do |format|
      @task.pause!
      get_sorted_tasks
      format.js { render 'pausebutton.js.coffee.erb' }
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
      format.js { render 'restart_reload.js.coffee.erb' }
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
    params.require(:task).permit(:title, :desc, :due_date, :tag_id)
  end
end