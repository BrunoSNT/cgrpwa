class StoresController < ApplicationController
  def index
    @main_page = "Recompensas"
    @page_title = "Loja"

    @itens = Item.where(available: true)
  end
end
