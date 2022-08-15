class UsersController < ApplicationController
  def index
    @message = 'Here is a list of all Users'
  end

  def show
    @message = "Here is the specific User: #{params[:id]}"
  end
end
