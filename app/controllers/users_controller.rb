class UsersController < ApplicationController
  before_action :authenticate_user!
  authorize_resource

  def index
    @users = User.all.order(:id)
  end

  def show
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to action: 'index'
  end
end
