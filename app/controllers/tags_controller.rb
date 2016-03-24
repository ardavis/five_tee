class TagsController < ApplicationController

  before_action :get_tag, only: [:destroy]

  def create
    @incomplete_tasks = current_user.incomplete_tasks
    @completed_tasks = current_user.completed_tasks
    @tag = current_user.tags.new(tag_params)
    @task = params[:current_task].present? ? current_user.tasks.find(params[:current_task].to_i) : current_user.tasks.new()
    if @tag.save
      @tag = current_user.tags.new()
      call_coffeescript('tags/reload_scripts/reload_on_new_tag.coffee.erb')
    else
      call_coffeescript('tags/reload_scripts/reload_on_fail_tag.coffee.erb')
    end
  end

  def destroy
    @incomplete_tasks = current_user.incomplete_tasks
    @completed_tasks = current_user.completed_tasks
    @session = current_user.session
    @session.update_attributes(filter_tag_id: nil) if @session.filter_tag_id == @tag.id
    @task = current_user.tasks.new()
    @tag.destroy
    @tag = current_user.tags.new()
    call_coffeescript('tags/reload_scripts/reload_on_tag_delete.coffee.erb')
  end


  private

  def tag_params
    params.require(:tag).permit(:name, :user_id)
  end

  def get_tag
    @tag = current_user.tags.find(params[:id])
  end


end
