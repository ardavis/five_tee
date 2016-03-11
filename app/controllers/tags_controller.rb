class TagsController < ApplicationController

  before_action :get_tag, only: [:destroy]

  def create
    @tag = Tag.new(tag_params)
    respond_to do |format|
      if @tag.save
        @tag = Tag.new()
        @task = Task.new()
        format.js { render 'new_tag.js.coffee.erb'}
        flash[:success] = "Tag successfully created!"
      else
        format.js {render 'fail_tag.js.erb'}
      end
    end
  end

  def new_tag_form
    respond_to do |format|
      @tag = Tag.new()
      flash[:success] = nil
      format.js { render 'new_tag_form.js.coffee.erb' }
    end
  end

  def destroy
    @task = Task.new()
    respond_to do |format|
      @tag.destroy
      @tag = Tag.new()
      flash[:success] = "Tag successfully deleted!"
      format.js { render 'after_tag_delete.js.erb' }
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
