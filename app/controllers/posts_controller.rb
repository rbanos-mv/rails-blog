class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(id: :desc)
  rescue ActiveRecord::RecordNotFound
    redirect_to users_path
  end

  def show
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to action: 'index'
  end
end
