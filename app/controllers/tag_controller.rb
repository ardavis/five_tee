class TagController < ApplicationController

  def new
    @tag = current_user.tags.new(tag_params)
    if @tag.save
      respond_to do |format|
        format.json { render json: {tag: @tag}}
      end
    end
  end

  private

  def tag_params
    params.require(:tag).permit(:name)
  end

end