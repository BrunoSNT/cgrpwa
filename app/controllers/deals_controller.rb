class DealsController < ApplicationController
  before_action :set_deal, only: [:show, :edit, :update, :destroy, :update_deal_status]


  def update_deal_status
    @deal.status = params[:status]
    respond_to do |format|
      if @deal.save
        format.html {}
        format.json {}
        format.js {}
      else
        format.html { }
        format.json { }
        format.js {}
      end
    end
  end
  # GET /deals
  # GET /deals.json
  def index
    @main_page = "Negociações"
    @page_title = "Minhas Negociações"
    @deals = current_user.deals
    @deal_status = Deal.statuses
  end

  def history_index
    @main_page = "Negociações"
    @page_title = "Histórico de Negociações"
    @deals = Deal.all
    respond_to do |format|
      format.html
      format.json { render json: DealDatatable.new(params) }
    end
  end

  # GET /deals/1
  # GET /deals/1.json
  def show
  end

  # GET /deals/new
  def new
    @deal = Deal.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  # GET /deals/1/edit
  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  # POST /deals
  # POST /deals.json
  def create
    @deal = Deal.new(deal_params)

    respond_to do |format|
      if @deal.save
        format.html { redirect_to deals_path, notice: 'Deal was successfully created.' }
        format.json { render :show, status: :created, location: @deal }
      else
        format.html { render :new }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deals/1
  # PATCH/PUT /deals/1.json
  def update
    respond_to do |format|
      if @deal.update(deal_params)
        format.html { redirect_to deals_path, notice: 'Deal was successfully updated.' }
        format.json { render :show, status: :ok, location: @deal }
      else
        format.html { render :edit }
        format.json { render json: @deal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deals/1
  # DELETE /deals/1.json
  def destroy
    @deal.destroy
    respond_to do |format|
      format.html { redirect_to deals_url, notice: 'Deal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_deal
      @deal = Deal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deal_params
      params.require(:deal).permit(:user_id, :deal_date, :client_name, :client_company, :sector, :sector_description, :problems, :address, :website, :telephone1, :telephone2, :email, :info, :arrival, :status, :price)
    end
end
