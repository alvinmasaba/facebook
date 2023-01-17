class PostsController < ApplicationController
  def index
    @posts = current_user.recent_friends_posts
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.save
    ActionCable.server.broadcast('post', @post.as_json(include: :author))
  end

  private

  def post_params
    params.require(:post).permit(:body)
  end
end