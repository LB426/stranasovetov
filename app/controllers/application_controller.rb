class ApplicationController < ActionController::Base
  before_action :require_login
  
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	helper_method :current_user

private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
	end

  def require_login
    unless current_user
      flash[:error] = "Мы не узнаём Вас, выполните вход!"
      redirect_to login_path
    end
  end

end
