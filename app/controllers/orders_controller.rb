class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :check_for_director_access, except: [:create, :new, :user_orders, :show]

  def toggle_status_entregue
    @order = Order.find params[:id]
    @order.status = 1
    @order.save

    redirect_to orders_path
  end

  def toggle_status_pendente
    @order = Order.find params[:id]
    @order.status = 0
    @order.save

    redirect_to orders_path
  end
  # GET /orders
  # GET /orders.json

  def user_orders
    @main_page = "Recompensas"
    @page_title = "Seus Pedidos"
    @orders = current_user.orders.order(created_at: :desc)
  end

  def index
    @main_page = "Admin"
    @page_title = "Pedidos"
    @orders = Order.all.order(created_at: :desc)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @main_page = "Admin"
    @page_title = "Ver Pedido"
  end

  # GET /orders/new
  def new
    @main_page = "Admin"
    @page_title = "Novo Pedido"
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
    @main_page = "Admin"
    @page_title = "Editar Pedido"
  end

  # POST /orders
  # POST /orders.json
  def create
    if Item.find(params[:order][:item_id]).value > current_user.coins
      respond_to do |format|
        format.html do
          flash[:danger] = 'Saldo insuficiente.'
          redirect_to store_path
        end
      end
    else
      @order = Order.new(order_params)

      respond_to do |format|
        if @order.save
          format.html { redirect_to @order, notice: 'Pedido efetuado com sucesso!' }
          format.json { render :show, status: :created, location: @order }
        else
          format.html { render :new }
          format.json { render json: @order.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Pedido atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Pedido deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :item_id, :status)
    end

    def check_for_director_access
      unless current_user.has_director_access?
        flash[:danger] = "Apenas diretores tem acesso à isso."
        redirect_to root_path
      end
    end
end
