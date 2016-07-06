class EmpresasController < ApplicationController
  before_action :require_user, only: [:index, :show]
  def new
    @empresa = Empresa.new
  end

  def create
    @empresa = Empresa.new(user_params)
    if @empresa.save(@empresa)
      session[:user_id] = @empresa.id
      redirect_to indexempresa_path
    else
      redirect_to '/empresas/signup'
    end
  end

  def show
    @empresa = Empresa.return_empresa_data(session[:user_id])
  end

  def inserir_vaga
    @ok = Empresa.inserir_nova_vaga(vaga_params)
    respond_to do |format|
      if @ok
        format.js
      end
    end
  end

  private
  def user_params
    params.require(:empresas).permit(:user_name, :password)
  end

  def vaga_params
    params.require(:cadastro_vaga).permit(:nome_vaga, :skills_necessarios, :descricao)
  end
end
