class TasksController < ApplicationController

  before_action :get_task, only: [:index, :show, :update, :update_duration, :destroy, :complete,
                                  :start, :restart, :pause]

  before_action :get_sorted_tasks, only: [:index, :update_duration, :create, :update, :destroy,
                                          :complete, :start, :pause, :restart]



  def index
    current_user.session = Session.new()
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
      @task = Task.new()
      flash[:success] = 'Task successfully created!'
      call_coffeescript('tasks/reload_scripts/reload_on_create.coffee.erb')
    else
      call_coffeescript('tasks/reload_scripts/reload_on_fail_create.coffee.erb')
    end
  end

  def update
    if @task.update_attributes(task_params)
      @task.update_attributes(due_date: fix_date(task_params['due_date']))
      call_coffeescript('tasks/reload_scripts/reload_on_update.coffee.erb')
    else
      call_coffeescript('tasks/reload_scripts/reload_on_fail_update.coffee.erb')
    end
  end

  def destroy
    @task.destroy
    call_coffeescript('tasks/reload_scripts/restart_reload.coffee.erb')
  end

  def complete
    @task.complete!
    call_coffeescript('tasks/reload_scripts/restart_reload.coffee.erb')
  end

  def start
    @task.start!(current_user)
    call_coffeescript('tasks/button_scripts/playbutton.coffee.erb')
  end

  def pause
    @task.pause!
    call_coffeescript('tasks/button_scripts/pausebutton.coffee.erb')
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

  def restart
    @task.restart!
    call_coffeescript('tasks/reload_scripts/restart_reload.coffee.erb')
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
