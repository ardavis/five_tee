class TasksController < ApplicationController

  before_action :get_task, only: [:show, :update, :destroy, :complete,
                                  :start, :restart, :pause]

  def index
    @task = Task.new()
    @incomplete_tasks = Task.incomplete
    @completed_tasks = Task.completed
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
    flash[:success] = "Task successfully edited!"
  end

  def show
  end

  def new_task_form
    respond_to do |format|
      @task = Task.new()
      flash[:success] = nil
      format.js { render 'new_task_form.js.erb' }
    end
  end


  def create
    @task = Task.new(task_params)
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
        get_sorted_tasks
        format.js { render 'reload_on_update.js.erb'}
      else
        format.html {render action: "index"}
        format.js {render 'reload_on_create'}
      end
    end
  end


  def destroy
    @task.destroy
    redirect_to root_path
  end

  def complete
    @task.complete!
    redirect_to tasks_path
  end

  def start
    @task.start!
    redirect_to tasks_path
  end

  def pause
    @task.pause!
    redirect_to tasks_path
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
    @task.restart!
    redirect_to tasks_path
  end


  def get_sorted_tasks
    @incomplete_tasks = Task.incomplete
    @completed_tasks = Task.completed
  end

  private

  def get_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :desc, :due_date)
  end
end