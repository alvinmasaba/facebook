class CommentsController < ActionController::Base
  before_action :set_comment, only: [:show, :update, :destroy]
  
  def show
    @comment
  end

  def update
    respond_to do |format|
      if @comment.update!(comment_params)
        format.html { redirect_to root_path }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end

      ActionCable.server.broadcast('post', nil)
    end
  end

  def destroy
    @comment.destroy

    ActionCable.server.broadcast('post', nil)
    
    flash[:notice] = "Comment was successfully destroyed."
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(likes_attributes: [:id, :user_id, :_destroy])
  end
end