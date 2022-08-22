class CommentsController < ApplicationController
  include ApplicationHelper

  def create
    @comment = Comment.new(params.require(:comment).permit(:author_id, :post_id, :text))

    author_id = @comment.author.id
    post_id = @comment.post.id

    if @comment.save
      flash[:notice] = 'Comment saved successfully'
      redirect_to user_post_path(author_id, post_id)
    else
      flash[:error] = 'Comment not saved'
      redirect_to new_user_post_comment_path(author_id, post_id)
    end
  end

  def new
    @comment = Comment.new(author_id: current_user.id, post_id: params[:post_id])
  end
end
