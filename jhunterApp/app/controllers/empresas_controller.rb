class EmpresasController < ApplicationController
  before_action :require_user, only: [:index, :show]
  def new
    @empresa = Empresa.new
  end

  def create
    @empresa = Empresa.new(user_params)
    if @empresa.save(@empresa)
      session[:user_id] = @empresa.id
      redirect_to index_path
    else
      redirect_to '/empresas/signup'
    end
  end

  private
  def user_params
    params.require(:empresas).permit(:user_name, :password)
  end
end
