class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_sesefore_action :authenticate_user!
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  def current_user=(user)
	  @current_user = user
	  session[:user_id] = user.try(:id).try(:to_s)
    end

  protected
  def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_up) << :name
    	devise_parameter_sanitizer.for(:sign_up) << :surname
    	devise_parameter_sanitizer.for(:sign_up) << :tel
  end

end

