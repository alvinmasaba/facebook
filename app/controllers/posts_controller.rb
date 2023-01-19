class PostsController < ApplicationController
  before_action :set_post, only: [ :update ]

  def index
    @post = Post.new
    @posts = current_user.recent_friends_posts
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    ActionCable.server.broadcast('post', @post.as_json(include: :author))
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
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:body, comments_attributes: [:id, :commenter_id, :body, :_destroy])
  end
end