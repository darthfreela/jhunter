class UserController < ApplicationController

  before_action :require_user, only: [:index, :show]
  def new
    @user = User.new
  end
  #
  def create
    @user = User.new(user_params)
    if @user.save(@user)
      session[:user_id] = @user.id
      redirect_to index_path
    else
      redirect_to '/signup'
    end
  end

  def show
    @user = User.return_user_data(session[:user_id])
  end

  private
  def user_params
    params.require(:users).permit(:user_name, :password, :faculdade, :cidade, :skills)
  end
end
