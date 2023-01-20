class CommentsController < ActionController::Base
  before_action :set_comment, only: [:show, :destroy]
  
  def show
    @comment
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to root_path, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end
end