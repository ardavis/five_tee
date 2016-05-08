class TasksController < ApplicationController

  include TasksHelper
  include TagsHelper

  def index
    respond_to do |format|
      format.html do
        render component: 'TasksIndex', props: {tasks: tasks_hash, tags: tags_hash}
      end
    end
  end

  def new
    @task = current_user.tasks.new(task_params)
    @task.due_date = fix_date(task_params[:due_date])
    if @task.save
      respond_to do |format|
        format.json { render json: {tasks: tasks_hash, tags: tags_hash}}
      end
    else
      render status: 400
    end
  end

  def update
    @task = current_user.tasks.find(task_params[:id])
    @params = task_params
    @params['due_date'] = fix_date(@params['due_date']) if @params.has_key? 'due_date'
    @params['started_at'] = Time.now if @params.has_key? 'duration' and @task.started_at
    if params[:tag_name]
      @tag = current_user.tags.create(name: params[:tag_name])
      if @tag.save
        @params['tag_id'] = @tag.id
      else
        render status: 400
      end
    end
    if @task.update_attributes(@params)
      puts tags_hash
      respond_to do |format|
        format.json { render json: {tasks: tasks_hash, tags: tags_hash, selected_task: react_task(@task)}}
      end
    else
      render status: 400
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
      format.json { render json: {tasks: tasks_hash, tags: tags_hash}}
    end
  end

  def select
    @task = current_user.tasks.find(task_params[:id])
    respond_to do |format|
      format.json { render json: react_task(@task)}
    end
  end

  def filter
    unless params[:tag][:id].blank?
      @filtered_tasks = current_user.tasks.where(tag_id: params[:tag][:id])
    else
      @filtered_tasks = current_user.tasks.all
    end
    respond_to do |format|
      format.json {render json: tasks_hash(@filtered_tasks)}
    end
  end


  def fetch_all
    respond_to do |format|
      format.json { render json: {tasks: tasks_hash}}
    end
  end


  private

  def task_params
    params.require(:task).permit(:id, :title, :desc, :tag_id, :due_date, :duration)
  end


end
