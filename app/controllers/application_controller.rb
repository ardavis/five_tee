class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  before_action :authenticate_user!




  def mid_string(string, start, fin)
    string[/#{Regexp.escape(start)}(.*?)#{Regexp.escape(fin)}/m, 1]
  end

end
