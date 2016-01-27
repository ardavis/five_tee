class TasksController < ApplicationController

  before_action :get_task, only: [:show, :edit, :update, :destroy, :complete,
                                  :start, :restart, :pause]

  def index
    @incomplete_tasks = Task.incomplete
    @completed_tasks = Task.completed
    running_update
  end

  def show
  end

  def new
    @task = Task.new
  end

  def edit
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path
    else
      render :new
    end
  end

  def update
    if @task.update_attributes(task_params)
      redirect_to task_path(@task)
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path
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

  def download
    #grab all the tasks, and pass them to the ruby code in the axlsx file, gem handles everything
    @tasks = Task.all
    render xlsx: 'download.xlsx.axlsx',filename: "taskSheet.xlsx"
  end

  def restart
    @task.restart!
    redirect_to tasks_path
  end

  def running_update
    @task = Task.running.first
    if @task
      @task.pause!
      @task.start!
    end
  end

  private

  def get_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :desc)
  end
end