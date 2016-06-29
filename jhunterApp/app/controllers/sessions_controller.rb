class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.new(user_params)
    @user = User.find(@user.user_name, @user.password)
    if @user
      session[:user_id] = @user.id
      redirect_to index_path
    else
      @empresa = Empresa.new(user_params)
      @empresa = Empresa.find(@empresa.user_name, @empresa.password)
      session[:user_id] = @empresa.id
      redirect_to index_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def user_params
    params.require(:users).permit(:user_name, :password)
  end
end
