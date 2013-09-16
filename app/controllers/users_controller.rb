class UsersController < ApplicationController
  before_filter :current_user?

  def index
    @users = User.where("id > 0").order("id DESC").load
    logger.debug @users[0].created_at
  end

  def new
  	@user = User.new
  end

  def create
	  @user = User.new(params[:user].permit(:login, :password))
	  if @user.save
	    redirect_to users_path, :notice => "Signed up!"
	  else
	    render "new"
	  end
	end
	
	def destroy
	  user = User.find_by_id(params[:id])
	  unless user.nil? 
	    user.destroy
	    msg = "Успешно удалён"
    else
      msg = "Нет такого пользователя"
    end
	  redirect_to users_path, :notice => msg
  end

end
