class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :authenticate_user!

  def call_coffeescript(path)
    respond_to do |format|
      format.js {render path}
    end
  end

  def reset_flash
    flash[:success] = nil
  end

end
