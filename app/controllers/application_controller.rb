class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

	helper_method :current_user
	helper_method :current_user?

	private

	def current_user
	  @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      flash[:notice] = "Пользователь не найден, выполните вход!"
      render :text => 'Not Found', :status => '404'
	end

  def current_user?
    unless current_user.nil?
      return true
    end
    flash[:notice] = "Мы не узнаём Вас, выполните вход!"
    redirect_to login_path
    return false
  end

end
