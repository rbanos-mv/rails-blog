class PostsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  include ApplicationHelper

  def create
    if @post.save
      flash[:notice] = 'Post saved successfully'
      redirect_to user_path(@post.author_id)
    else
      flash[:error] = 'Post not saved'
      redirect_to new_user_post_path(@post.author_id)
    end
  end

  def destroy
    @post.destroy

    if current_page?(user_post_path(@post.author_id, @post.id))
      redirect_to user_posts_path(@post.author_id)
    else
      redirect_to request.referer
    end
  end

  def index
    author_id = params[:user_id]
    @posts = @posts.includes([:author]).rewhere(author_id:)
    @user = @posts.length.zero? ? User.find(author_id) : @posts.first.author
  end

  def new
    # automated
  end

  def show
    # automated
    #   @post = Post.find(params[:id])
    # rescue ActiveRecord::RecordNotFound
    #   redirect_to action: 'index'
  end

  protected

  def post_params
    # params.require(:post).permit(:title, :text).merge({ author_id: params[:user_id] }.permit(:author_id))
    params.require(:post).permit(:author_id, :title, :text)
  end
end
