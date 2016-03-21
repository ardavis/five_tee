class TagsController < ApplicationController

  before_action :get_tag, only: [:destroy]

  def create
    @tag = Tag.new(tag_params)
    @task = params[:current_task].present? ? Task.find(params[:current_task].to_i) : Task.new()
    if @tag.save
      @tag = Tag.new()
      flash[:success] = 'Tag successfully created!'
      call_coffeescript('tags/reload_scripts/reload_on_new_tag.coffee.erb')
    else
      call_coffeescript('tags/reload_scripts/reload_on_fail_tag.coffee.erb')
    end
  end

  def destroy
    @task = Task.new()
    @tag.destroy
    @tag = Tag.new()
    flash[:success] = 'Tag successfully deleted!'
    call_coffeescript('tags/reload_scripts/reload_on_tag_delete.coffee.erb')
  end


  private

  def tag_params
    params.require(:tag).permit(:name, :user_id)
  end

  def get_tag
    @tag = Tag.find(params[:id])
  end


end
