class LikesController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  include ApplicationHelper

  def create
    author_id = current_user.id
    post_id = params[:post_id]

    return if Like.where(author_id:, post_id:).exists?

    @like = Like.new(author_id:, post_id:)
    authorize! :create, @like

    @like.save

    redirect_to request.referrer
  end
end
