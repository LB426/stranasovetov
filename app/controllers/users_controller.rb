class UsersController < ApplicationController
  before_filter :current_user?

  def index
  end

  def new
  	@user = User.new
  end

  def create
	  @user = User.new(params[:user].permit(:login, :password))
	  if @user.save
	    redirect_to root_url, :notice => "Signed up!"
	  else
	    render "new"
	  end
	end

end
