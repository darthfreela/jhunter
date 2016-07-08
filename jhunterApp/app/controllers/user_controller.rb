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
    @skills_faltando = Array.new
    @skills_user = User.return_skills_user(session[:user_id])
    @skills_vaga = User.return_skills_interesses(session[:user_id])
    @skills_vaga.each do |s|
      @x = s[1]
    end
      if @skills_vaga.nil?
        @nome_da_vaga = @kills_vaga[0][0]
      end
      if !@x.nil?
        a = @x.split(/,/)
      end
      if !@skills_user.nil?
        b = @skills_user.split(/,/)
        b = b[0]
      end
      #verificar quais skills o usuario não possui
      c = nil
      if !a.nil? && !b.nil?
        b.each do |dado|
          a.delete(dado)
        end
      end
      if !b.nil?
        @skills_faltando = a
      end
      if @skills_faltando.nil?
        @skills_faltando = Array.new
      end

  end

  private
  def user_params
    params.require(:users).permit(:user_name, :password, :faculdade, :cidade, :skills)
  end

  def interesse_params
    params.require(:interesse).permit(:id_empresa, :nome_vaga, :skills_necessarios, :descricao)
  end
end
