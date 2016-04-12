class TagsController < ApplicationController

  include ApplicationHelper


  before_action :get_tag, only: [:destroy, :select]

  before_action :get_sorted_tasks, only: [:create, :destroy]

  def create
    # byebug
    @tag = current_user.tags.new(tag_params)
    if @tag.save!
      respond_to do |format|
        format.json {render json: {selected_tag: react_tag(@tag), tags: react_tags_hash}}
      end
    else
      render status: 400
    end
  end

  def select
    respond_to do |format|
      format.json {render json: react_tag(@tag)}
    end
  end

  def destroy
    @session = current_user.session
    @session.update_attributes(filter_tag_id: nil) if @session.filter_tag_id == @tag.id
    @task = current_user.tasks.new()
    @tag.destroy
    @tag = current_user.tags.new()
    call_coffeescript('tags/reload_scripts/reload_on_tag_delete.coffee.erb')
  end


  private

  def tag_params
    params.permit(:name, :id)
  end

  def get_tag
    @tag = current_user.tags.find(tag_params[:id])
  end


end
