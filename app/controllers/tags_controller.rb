class TagsController < ApplicationController

  include TagsHelper
  include TasksHelper

  def new
    @tag = current_user.tags.new(tag_params)
    if @tag.save
      respond_to do |format|
        format.json { render json: {tags: tags_hash, tag: react_tag(@tag)}}
      end
    end
  end

  def update
    @tag = current_user.tags.find(tag_params[:id])
    if @tag.update_attributes(name: tag_params[:name])
      respond_to do |format|
        format.json { render json: {tasks: tasks_hash, tags: tags_hash}}
      end
    else
      puts "HARD FAIL"
    end
  end

  def delete
    @tag = current_user.tags.find(tag_params[:id])
    if @tag.destroy
      respond_to do |format|
        format.json { render json: {tasks: tasks_hash, tags: tags_hash}}
      end
    else
      puts "HARD FAIL"
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name, :id)
  end

end