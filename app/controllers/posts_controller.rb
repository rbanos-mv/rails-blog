class PostsController < ApplicationController
  before_action :authenticate_user!

  include ApplicationHelper

  def create
    @post = Post.new(params.require(:post).permit(:author_id, :title, :text))

    if @post.save
      flash[:notice] = 'Post saved successfully'
      redirect_to user_path(@post.author_id)
    else
      flash[:error] = 'Post not saved'
      redirect_to new_user_post_path(@post.author_id)
    end
  end

  def index
    @user = User.find(params[:user_id])
    @posts = @user.posts.order(id: :desc)
  rescue ActiveRecord::RecordNotFound
    redirect_to users_path
  end

  def new
    p current_user
    @post = Post.new(author_id: current_user.id)
  end

  def show
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to action: 'index'
  end
end
