class TagsController < ApplicationController

  before_action :get_tag, only: [:destroy]

  def create
    @tag = Tag.new(tag_params)
    respond_to do |format|
      if @tag.save
        @tag = Tag.new()
        @task = params[:current_task].present? ? Task.find(params[:current_task].to_i) : Task.new()
        format.js { render 'new_tag.coffee.erb'}
        flash[:success] = "Tag successfully created!"
      else
        format.js {render 'fail_tag.coffee.erb'}
      end
    end
  end

  def new_tag_form
    @tag = Tag.new()
    @task = params[:task_id].present? ? Task.find(params[:task_id].to_i) : Task.new()
    respond_to do |format|
      flash[:success] = nil
      format.js { render 'new_tag_form.coffee.erb' }
    end
  end

  def destroy
    @task = Task.new()
    respond_to do |format|
      @tag.destroy
      @tag = Tag.new()
      flash[:success] = "Tag successfully deleted!"
      format.js { render 'after_tag_delete.coffee.erb' }
    end
  end


  private

  def tag_params
    params.require(:tag).permit(:name)
  end

  def get_tag
    @tag = Tag.find(params[:id])
  end


end
