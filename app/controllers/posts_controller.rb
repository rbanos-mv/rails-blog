class PostsController < ApplicationController
  def index
    @message = "Here is a list of all Posts by User with id: #{params[:user_id]}"
  end

  def show
    @message = "Here is the specific Post with id: #{params[:id]} by User with id: #{params[:user_id]}"
  end
end
