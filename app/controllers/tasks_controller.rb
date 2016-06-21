class TasksController < ApplicationController

  before_action :get_task, only: [:update, :start, :pause, :complete, :restart, :delete, :select]

  def index
    respond_to do |format|
      format.html do
        render component: 'TasksIndex', props: {tasks: current_user.tasks_hash,
                                                tags: current_user.tags_hash,
                                                sort_options: Session.sort_options,
                                                sort_title: current_user.session.sort_title,
                                                filter_tag: current_user.session.filter_tag}
      end
    end
  end

  def new
    @task = current_user.tasks.new(task_params)
    @task.due_date = fix_date(task_params[:due_date])
    if @task.save
      respond_to do |format|
        format.json { render json: {tasks: current_user.tasks_hash, tags: current_user.tags_hash}}
      end
    else
      render status: 400
    end
  end

  def update
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
      respond_to do |format|
        format.json { render json: {tasks: current_user.tasks_hash,
                                    tags: current_user.tags_hash,
                                    selected_task: @task.react_task}}
      end
    else
      render status: 400
    end
  end

  def reset
    filtered_tasks.where(archive_id: nil).each{ |task| task.update_attributes(completed_at: nil, duration: nil)}
    return_tasks
  end

  def start
    @task.start!(current_user)
    return_tasks
  end

  def pause
    @task.pause!
    return_tasks
  end

  def complete
    @task.complete!
    return_tasks
  end

  def restart
    @task.restart!
    return_tasks
  end

  def delete
    @task.destroy!
    respond_to do |format|
      format.json { render json: {tasks: current_user.tasks_hash, tags: current_user.tags_hash}}
    end
  end

  def select
    respond_to do |format|
      format.json { render json: @task.react_task}
    end
  end

  def filter
    current_user.session.update_attributes(filter_tag_id: params[:tag][:id])
    respond_to do |format|
      format.json { render json: current_user.tasks_hash}
    end
  end

  def sort
    current_user.session.update_attributes(sort_sql: params[:sql])
    respond_to do |format|
      format.json { render json: current_user.tasks_hash}
    end
  end

  def download
    @incomplete_tasks = filtered_tasks.where(archive_id: nil).where(completed_at: nil).order(current_user.session.sort_sql)
    @complete_tasks = filtered_tasks.where(archive_id: nil).where.not(completed_at: nil).order(current_user.session.sort_sql)
    render xlsx: 'download.xlsx.axlsx',filename: "tasks_from_#{Time.now.strftime('%m-%d-%Y')}.xlsx"
  end

  private

  def return_tasks
    respond_to do |format|
      format.json { render json: {tasks: current_user.tasks_hash}}
    end
  end

  def get_task
    @task = Task.find(task_params[:id])
  end

  def task_params
    params.require(:task).permit(:id, :title, :desc, :tag_id, :due_date, :duration)
  end

  def download_html
    html = render_to_string(template: "downloads/task_index_download.html.erb")
    html[0, html.rindex('</div>')]
  end

  def fix_date(date)
    return nil if date.blank?
    fixed_date = date[3..5]
    fixed_date << date[0..2]
    fixed_date << date[6..9]
  end

end
