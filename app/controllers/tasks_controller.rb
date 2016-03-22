class TasksController < ApplicationController

  before_action :get_task, only: [:show, :update, :update_duration, :destroy, :complete,
                                  :start, :restart, :pause]

  def index
    get_task
    @tag = current_user.tags.new
    get_sorted_tasks
  end

  def update_duration
    if @task.started_at
      @task.pause!
      @task.start!(current_user)
    end
    if @task.update_attributes(task_params)
      get_sorted_tasks
      call_coffeescript('tasks/reload_scripts/reload_updated_duration.coffee.erb')
    end
  end

  def create
    @task = current_user.tasks.new(task_params)
    @task.update_attributes(due_date: fix_date(task_params['due_date']))
      get_sorted_tasks
    if @task.save
      @task = Task.new()
      get_sorted_tasks
      flash[:success] = 'Task successfully created!'
      call_coffeescript('tasks/reload_scripts/reload_on_create.coffee.erb')
    else
      call_coffeescript('tasks/reload_scripts/reload_on_fail_create.coffee.erb')
    end
  end

  def update
    if @task.update_attributes(task_params)
      @task.update_attributes(due_date: fix_date(task_params['due_date']))
      get_sorted_tasks
      call_coffeescript('tasks/reload_scripts/reload_on_update.coffee.erb')
    else
      call_coffeescript('tasks/reload_scripts/reload_on_fail_update.coffee.erb')
    end
  end

  def destroy
    @task.destroy
    get_sorted_tasks
    call_coffeescript('tasks/reload_scripts/restart_reload.coffee.erb')
  end

  def complete
    @task.complete!
    get_sorted_tasks
    call_coffeescript('tasks/reload_scripts/restart_reload.coffee.erb')
  end

  def start
    @task.start!(current_user)
    get_sorted_tasks
    call_coffeescript('tasks/button_scripts/playbutton.coffee.erb')
  end

  def pause
    @task.pause!
    get_sorted_tasks
    call_coffeescript('tasks/button_scripts/pausebutton.coffee.erb')
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
    get_sorted_tasks
    call_coffeescript('tasks/reload_scripts/restart_reload.coffee.erb')
  end

  def get_sorted_tasks
    @incomplete_tasks = current_user.incomplete_tasks
    @completed_tasks = current_user.completed_tasks
  end

  private

  def get_task
    if params[:id]
      @task = Task.find(params[:id])
    else
      @task = current_user.tasks.new
    end
  end

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
