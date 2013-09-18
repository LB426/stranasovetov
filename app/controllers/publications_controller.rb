class PublicationsController < ApplicationController
  skip_before_action :require_login, only: [:show]
  
  def index
    @publications = Publication.where("user_id = ?", current_user).order("created_at DESC")
  end
  
  def new
    @publication = current_user.publications.new
  end
  
  def create
    @publication = current_user.publications.new(params[:publication].permit(:title, :text))
    if @publication.save
      redirect_to @publication
    else
      render "new"
    end
  end
  
  def show
    @publication = Publication.find(params[:id])
  end
  
  def edit
    @publication = current_user.publications.find(params[:id])
  end
  
  def update
    @publication = current_user.publications.find(params[:id])
    if @publication.update_attributes(params[:publication].permit(:title, :text))
	    render "show"
	  else
	    render "edit"
	  end
  end
  
  def destroy
    @publication = current_user.publications.find(params[:id])
    @publication.destroy
    redirect_to publications_path
  end
  
end
