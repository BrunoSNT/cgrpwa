class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :check_for_director_access

  def toggle_status_sim
    @item = Item.find params[:id]
    @item.available = true
    @item.save

    redirect_to items_path
  end

  def toggle_status_nao
    @item = Item.find params[:id]
    @item.available = false
    @item.save

    redirect_to items_path
  end
  # GET /items
  # GET /items.json
  def index
    @main_page = "Admin"
    @page_title = "Itens"
    @items = Item.all
  end

  # GET /items/1
  # GET /items/1.json
  def show
    @main_page = "Admin"
    @page_title = "Item"
  end

  # GET /items/new
  def new
    @main_page = "Admin"
    @page_title = "Novo Item"
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
    @main_page = "Admin"
    @page_title = "Editar Item"
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item criado com sucesso.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(:name, :description, :value, :quantity, :image, :available)
    end

    def check_for_director_access
      unless current_user.has_director_access?
        flash[:danger] = "Apenas diretores tem acesso à isso."
        redirect_to root_path
      end
    end
end
