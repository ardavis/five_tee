class TasksController < ApplicationController

  before_action :get_task, only: [:show, :edit, :update, :destroy, :complete,
                                  :start, :pause]

  def index
    @incomplete_tasks = Task.incomplete
    @completed_tasks = Task.completed
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

  private

  def get_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :desc)
  end
end