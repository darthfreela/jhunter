class UserController < ApplicationController

  before_action :require_user, only: [:index, :show]
  before_action :atualiza_status_vaga, only: [:index, :show]
  def new
    @user = User.new
  end
  #
  def create
    @user = User.new(user_params)
    if @user.save(@user)
      session[:user_id] = @user.id
      redirect_to indexuser_path
    else
      redirect_to '/signup'
    end
  end

  def show
    @user = User.return_user_data(session[:user_id])
    @empresas = Empresa.all
  end

  def inserir_interesse
    User.inserir_interesse(interesse_params, session[:user_id])
    redirect_to '/indexuser'
  end

  #metodo de controle de interesses
  def atualiza_status_vaga
    @skills_user = User.return_skills_user(session[:user_id])
    @skills_vaga = User.return_skills_interesses(session[:user_id])
  end

  private
  def user_params
    params.require(:users).permit(:user_name, :password, :faculdade, :cidade, :skills)
  end

  def interesse_params
    params.require(:interesse).permit(:id_empresa, :nome_vaga, :skills_necessarios, :descricao)
  end
end
