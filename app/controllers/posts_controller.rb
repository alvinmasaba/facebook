class PostsController < ApplicationController
  before_action :set_post, only: [:update, :destroy]

  def index
    @post = Post.new
    @posts = current_user.recent_friends_posts
  end

  def create
    if params[:user_id]
      @post = User.find(params[:user_id]).posts.build(post_params)
    else
      @post = current_user.posts.build(post_params)
    end

    @post.save
    ActionCable.server.broadcast('post', @post)
  end

  def update
    respond_to do |format|
      if @post.update!(post_params)
        format.html { redirect_to root_path }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :index, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
      
      ActionCable.server.broadcast('post', nil)
    end
  end

  def destroy
    @post.destroy

    respond_to do |format|
      format.html { ActionCable.server.broadcast('post', nil) }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, :user_id, :author_id,
                                  comments_attributes: [:id, :commenter_id, :body, :_destroy, 
                                  likes_attributes: [:id, :user_id, :_destroy]], 
                                  likes_attributes: [:id, :user_id, :_destroy])
  end
end