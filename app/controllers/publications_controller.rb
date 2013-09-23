class PublicationsController < ApplicationController
  skip_before_action :require_login, only: [:show]
  
  def index
    @publications = Publication.where("user_id = ?", current_user).order("created_at DESC")
  end
  
  def new
    @publication = current_user.publications.new
  end
  
  def create
    @publication = current_user.publications.new(params.require(:publication).permit(:title, :text, images_attributes: [:user_id, :picture]))
    if @publication.save
      redirect_to @publication
    else
      render "new"
    end
  end
  
  def show
    @publication = Publication.find(params[:id])
    @images = @publication.images.where("user_id = ?", current_user).order("id ASC")
    @publication_text_arr_abzac = @publication.text.split("\r")
    @publication_text = @publication.text.gsub("\r","</p><p>\r")
  end
  
  def edit
    @publication = current_user.publications.find(params[:id])
    @images = @publication.images.where("user_id = ?", current_user).order("id ASC")
  end
  
  def update
    @publication = current_user.publications.find(params[:id])
    if @publication.update_attributes(params.require(:publication).permit(:title, :text, images_attributes: [:user_id, :picture, :_destroy, :id, :size, :description, :align]))
	    redirect_to @publication
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
