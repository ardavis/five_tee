class TasksController < ApplicationController

  include TasksHelper

  def index
    respond_to do |format|
      format.html do
        render component: 'TasksIndex', props: {tasks: tasks_hash}
      end
    end
  end

  def start
    @task = current_user.tasks.find(task_params[:id])
    @task.start!(current_user)
    respond_to do |format|
      format.json { render json: {tasks: tasks_hash}}
    end
  end

  def pause
    @task = current_user.tasks.find(task_params[:id])
    @task.pause!
    respond_to do |format|
      format.json { render json: {tasks: tasks_hash}}
    end
  end

  def complete
    @task = current_user.tasks.find(task_params[:id])
    @task.complete!
    respond_to do |format|
      format.json { render json: {tasks: tasks_hash}}
    end
  end

  def restart
    @task = current_user.tasks.find(task_params[:id])
    @task.restart!
    respond_to do |format|
      format.json { render json: {tasks: tasks_hash}}
    end
  end

  def delete
    @task = current_user.tasks.find(task_params[:id])
    @task.destroy!
    respond_to do |format|
      format.json { render json: {tasks: tasks_hash}}
    end
  end



  def fetch_all
    respond_to do |format|
      format.json { render json: {tasks: tasks_hash}}
    end
  end


  private

  def task_params
    params.require(:task).permit(:id)
  end

end
