class CommentsController < ApplicationController
  skip_before_action :require_login, only: [:index, :create]
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @publication = Publication.find(params[:publication_id])
    @comments = Comment.where("publication_id = ?", @publication.id).order("id ASC")
    @comment = Comment.new
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @publication = Publication.find(params[:publication_id])
    anonymous = User.find_by_login("anonymous")
    @comment = Comment.new(comment_params)
    if current_user
      @comment.user_id = current_user.id
    else
      @comment.user_id = anonymous.id
    end

    respond_to do |format|
      if current_user
        if @comment.save
          format.html { redirect_to publication_comments_path(@publication,@comment) }
        else
          flash[:notice] = "Ошибка! Пустой комментарий."
          format.html { redirect_to publication_comments_path(@publication,@comment) }
        end
      else
        if verify_recaptcha( :model => @comment, :message => "Неправильно ввели буквы с картинки!" ) && @comment.save
          format.html { redirect_to publication_comments_path(@publication,@comment) }
        else
          flash[:notice] = "Ошибка! Пустой комментарий или неправильные буквы с картинки."
          format.html { redirect_to publication_comments_path(@publication,@comment) }
        end
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      #@comment = Comment.find(params[:id])
      @comment = Comment.where("publication_id = ? AND id = ?", params[:publication_id], params[:id])
      if @comment.size == 0
        raise ActiveRecord::RecordNotFound
      end
      rescue ActiveRecord::RecordNotFound
        flash[:notice] = 'Комментарий не найден'
        redirect_to root_path
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:user_id, :publication_id, :body)
    end
end
