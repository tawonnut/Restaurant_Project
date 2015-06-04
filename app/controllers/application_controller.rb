class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_sesefore_action :authenticate_user!
  before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?


  def current_user=(user)
	  @current_user = user
	  session[:user_id] = user.try(:id).try(:to_s)
  end

    
  def after_sign_in_path_for(resource)
    if current_user.super_user?
      if current_user.current_restuarant == nil
        restuarants_path
      else    
        restuarant_path(current_user.current_restuarant)
      end
    else
      @restuarant = Membership.where(user_id: current_user.id)
      restuarant_path(@restuarant[0].restuarant_id)
    end
  end

    helper_method :current_restuarant

  after_filter :set_csrf_cookie_for_ng
  

  protected
  def configure_permitted_parameters
    	devise_parameter_sanitizer.for(:sign_up) << :name
    	devise_parameter_sanitizer.for(:sign_up) << :surname
    	devise_parameter_sanitizer.for(:sign_up) << :tel
      devise_parameter_sanitizer.for(:sign_up) << :super_user
      devise_parameter_sanitizer.for(:sign_up) << :restuarant_id
  end
    # AngularJS CSRF protection
  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  def verified_request?
    super || valid_authenticity_token?(session, request.headers['X-XSRF-TOKEN'])
  end

end

