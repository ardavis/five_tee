class TagsController < ApplicationController


  def new
    @tag = Tag.new(tag_params)
    if @tag.save
      respond_to do |format|
        format.json { render json: {tags: current_user.tags_hash, tag: @tag.react_tag}}
      end
    end
  end

  def update
    @tag = Tag.find(tag_params[:id])
    if @tag.update_attributes(name: tag_params[:name])
      respond_to do |format|
        format.json { render json: {tasks: current_user.tasks_hash, tags: current_user.tags_hash}}
      end
    else
      puts "HARD FAIL"
    end
  end

  def delete
    @tag = Tag.find(tag_params[:id])
    if @tag.destroy
      current_user.session.update_attributes(filter_tag_id: nil) if current_user.session.filter_tag_id == @tag.id
      respond_to do |format|
        format.json { render json: {tasks: current_user.tasks_hash, tags: current_user.tags_hash}}
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