class UsersController < ApplicationController

  def index
  	if current_user.group =~ /администратор/
    	@users = User.where("id > 0").order("id DESC").load
    	logger.debug @users[0].created_at
    else
	  	redirect_to root_path, :notice => "Для просмотра списка пользователей нужны права администратора!"
	  end
  end

  def new
  	if current_user.group =~ /администратор/
	  	@user = User.new
	  else
	  	redirect_to root_path, :notice => "Для создания пользователя нужны права администратора!"
	  end
  end

  def create
  	if current_user.group =~ /администратор/
		  @user = User.new(params[:user].permit(:login, :password, :fio, :group))
		  if @user.save
		    redirect_to users_path, :notice => "Signed up!"
		  else
		    render "new"
		  end
	  else
	  	redirect_to root_path, :notice => "Для создания пользователя нужны права администратора!"
	  end
	end
	
	def destroy
		if current_user.group =~ /администратор/
		  user = User.find_by_id(params[:id])
		  unless user.nil? 
		    user.destroy
		    msg = "Успешно удалён"
	    else
	      msg = "Нет такого пользователя"
	    end
		  redirect_to users_path, :notice => msg
	  else
	  	redirect_to root_path, :notice => "Для удаления пользователя нужны права администратора!"
	  end
  end

  def edit
  	if current_user.group =~ /администратор/
	  	@user = User.find_by_id(params[:id])
	  	if @user.nil?
	      flash[:notice] = "Пользователь не найден!"
	      redirect_to root_path
	    end
	  else
	  	@user = current_user
	  end
  end

  def update
  	if current_user.group =~ /администратор/
  		@user = User.find_by_id(params[:id])
  		if @user.update_attributes(params[:user].permit(:login, :password, :fio, :group, :avatar, :characterization))
		    redirect_to users_path, :notice => "Изменения внесены успешно!"
		  else
		  	flash[:notice] = "Изменения в настройки пользователя внести не удалось"
		    render "edit"
		  end
  	else
	  	@user = current_user
	  	if @user.update_attributes(params[:user].permit(:password, :avatar, :fio, :characterization))
		    redirect_to edit_user_path(@user), :notice => "Изменения внесены успешно!"
		  else
		  	flash[:notice] = "Изменения в настройки пользователя внести не удалось"
		    render "edit"
		  end
	  end
  end
  
  def show
    @user = User.find_by_id(params[:id])
  end

end
