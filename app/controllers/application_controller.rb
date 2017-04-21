class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper

  def require_user_login
  	unless logged_in?
		flash[:danger] = "Please log in"
		redirect_to login_path
  	end
  end
end
