class CommentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  include ApplicationHelper

  def create
    author_id = @comment.author_id
    post_id = @comment.post_id

    if @comment.save
      flash[:notice] = 'Comment saved successfully'
      redirect_to user_post_path(author_id, post_id)
    else
      flash[:error] = 'Comment not saved'
      redirect_to new_user_post_comment_path(author_id, post_id)
    end
  end

  def destroy
    @comment.destroy
    redirect_to request.referer
  end

  def new
    # automated
  end

  protected

  def comment_params
    params.require(:comment).permit(:text).merge(params.slice(:post_id).permit(:post_id))
  end
end
