class NegociatorsController < ApplicationController
  def index
    @main_page = "Negociações"
    @page_title = "Torre de Vendas"
  end

  def negotiations
    @main_page = "Negociações"
    @page_title = "Minhas Negociações"
    @negotiations = UserProject.where(user_id: current_user.id).where(role_id: Role.find_by(name: "Negociador").id)
  end
end
