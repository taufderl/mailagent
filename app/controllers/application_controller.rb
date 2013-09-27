class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # Catching exceptions from Cancan
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to start_url, alert: exception.message
  end
  
  # Workaround for mass-assignment with cancan
  before_filter do
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
  
  def current_user
    @current_user ||= User.find(session[:user]) if session[:user]
  end
  helper_method :current_user

end
