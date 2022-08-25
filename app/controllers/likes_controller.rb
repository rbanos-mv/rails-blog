class LikesController < ApplicationController
  include ApplicationHelper
  authorize_resource

  def create
    author_id = current_user.id
    post_id = params[:post_id]

    return if Like.where(author_id:, post_id:).exists?

    @like = Like.new(author_id:, post_id:)
    @like.save

    redirect_to request.referrer
  end
end
