class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_sesefore_action :authenticate_user!
  # before_action :authenticate_user!
  protect_from_forgery with: :exception

  def current_user=(user)
	  @current_user = user
	  session[:user_id] = user.try(:id).try(:to_s)
    end
end

