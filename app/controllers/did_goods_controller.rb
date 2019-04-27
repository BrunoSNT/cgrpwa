class DidGoodsController < ApplicationController
  before_action :set_did_good, only: [:show, :edit, :update, :destroy]

  # GET /did_goods
  # GET /did_goods.json
  def index
    @main_page = "Pessoal"
    @page_title = "DidGoods"
    @did_goods = DidGood.all
  end

  # GET /did_goods/1
  # GET /did_goods/1.json
  def show
    @main_page = "Pessoal"
    @page_title = "DidGood"
  end

  def new_superdidgood
    @main_page = "Pessoal"
    @page_title = "Novo Mandou-superbem"
    @did_good = DidGood.new(is_superdidgood: true)
    @preco_supermandoubem = Setup.last.superdidgood_price
  end
  # GET /did_goods/new
  def new
    @main_page = "Pessoal"
    @page_title = "Novo Mandou-bem"
    @did_good = DidGood.new
  end

  # GET /did_goods/1/edit
  def edit
  end

  # POST /did_goods
  # POST /did_goods.json
  def create
    @did_good = DidGood.new(did_good_params)
    @preco_supermandoubem = Setup.last.superdidgood_price

    if @did_good.is_superdidgood
      if current_user.coins < @preco_supermandoubem
        flash[:danger] = "Saldo insuficiente pra mandar Mandou-superbem"
        redirect_to did_goods_path and return
      end
    end
    respond_to do |format|
      if @did_good.save
        format.html { redirect_to @did_good, notice: 'Mandou bem enviado.' }
        format.json { render :show, status: :created, location: @did_good }
      else
        format.html { render :new }
        format.json { render json: @did_good.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /did_goods/1
  # PATCH/PUT /did_goods/1.json
  def update
    respond_to do |format|
      if @did_good.update(did_good_params)
        format.html { redirect_to @did_good, notice: 'Mandou bem atualizado.' }
        format.json { render :show, status: :ok, location: @did_good }
      else
        format.html { render :edit }
        format.json { render json: @did_good.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /did_goods/1
  # DELETE /did_goods/1.json
  def destroy
    @did_good.destroy
    respond_to do |format|
      format.html { redirect_to did_goods_url, notice: 'Mandou bem deletado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_did_good
      @did_good = DidGood.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def did_good_params
      params.require(:did_good).permit(:sender_id, :receiver_id, :description, :signature, :photourl, :is_superdidgood, :photo)
    end
end
