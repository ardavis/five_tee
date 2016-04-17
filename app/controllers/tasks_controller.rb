class TasksController < ApplicationController

  include ApplicationHelper

  before_action :get_task, only: [:index, :show, :update, :update_duration, :destroy, :complete,
                                  :start, :restart, :pause]

  before_action :get_sorted_tasks, only: [:index, :update_duration, :create, :update, :destroy,
                                          :complete, :start, :pause, :restart, :reset_all]
  include TasksHelper

  def show
    respond_to do |format|
      format.json { render json: react_task(@task)}
    end
  end

  def index
    current_user.session = Session.new(sort_sql: 'lower(title) ASC')
    @tag = current_user.tags.new
  end

  def update_duration
    if @task.started_at
      @task.pause!
      @task.start!(current_user)
    end
    if @task.update_attributes(task_params)
      call_coffeescript('tasks/reload_scripts/reload_updated_duration.coffee.erb')
    end
  end

  def create
    @task = current_user.tasks.new(task_params)
    @task.update_attributes(due_date: fix_date(task_params['due_date']))
    if @task.save
      react_json
    else
      render status: 400
    end
  end

  def update
    if @task.update_attributes(task_params)
      @task.update_attributes(due_date: fix_date(task_params['due_date']))
      react_json
    else
      render status: 400
    end
  end

  def destroy
    @task.destroy
    react_json
  end

  def complete
    @task.complete!
    react_json
  end

  def restart
    @task.restart!
    react_json
  end


  def start
    @task.start!(current_user)
    react_json
  end

  def pause
    @task.pause!
    react_json
  end

  def download_all
    #grab all the tasks, and pass them to the ruby code in the axlsx file, gem handles everything
    @tasks = current_user.tasks.all
    render xlsx: 'download.xlsx.axlsx',filename: "allTasks.xlsx"
  end

  def download_incompleted
    #grab all the tasks, and pass them to the ruby code in the axlsx file, gem handles everything
    @tasks = current_user.tasks.incomplete
    render xlsx: 'download.xlsx.axlsx',filename: "incompletedTasks.xlsx"
  end

  def download_completed
    #grab all the tasks, and pass them to the ruby code in the axlsx file, gem handles everything
    @tasks = current_user.tasks.completed
    render xlsx: 'download.xlsx.axlsx',filename: 'completedTasks.xlsx'
  end



  def reset_all
    @current_tasks = filtered_sorted_tasks(current_user.tasks.where(archive_id: nil))
    if params[:archive] and @current_tasks.count > 0
      @archive = current_user.archives.create!
      @current_tasks.each do |task|
        update_duration_if_running!(task)
        @task = task.dup
        @task.update(archive_id: @archive.id, archive_tag: task.tag_id ?  Tag.find(task.tag_id).name : nil)
        @task.update(created_at: task.created_at)
        @task.save
      end
    end
    @current_tasks.each do |task|
      task.update(duration: 0, completed_at: nil)
    end
    call_coffeescript('tasks/reload_scripts/reset_tasks_reload.coffee.erb')
  end

  private

  def task_params
    params.require(:task).permit(:title, :desc, :due_date, :tag_id, :duration)
  end

  def fix_date(date)
    return '' if date.blank?
    fixed_date = date[3..5]
    fixed_date << date[0..2]
    fixed_date << date[6..9]
  end



end
