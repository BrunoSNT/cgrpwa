class RepaysController < ApplicationController
  before_action :set_repay, only: [:show, :edit, :update, :destroy, :update_repay_status]
  before_action :check_for_director_access, only: [:index, :update_repay_status]

  def update_repay_status
    @repay.status = params[:status]
    respond_to do |format|
      if @repay.save
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
  # GET /repays
  # GET /repays.json
  def index
    @main_page = "Admin"
    @page_title = "Reembolsos"
    @repays = Repay.all
    @repay_status = Repay.statuses
  end

  # GET /repays/1
  # GET /repays/1.json
  def show
  end

  # GET /repays/new
  def new
    @main_page = "Admin"
    @page_title = "Novo pedido"
    @repay = Repay.new
  end

  # GET /repays/1/edit
  def edit
    @main_page = "Admin"
    @page_title = "Editar pedido"
  end

  # POST /repays
  # POST /repays.json
  def create
    @repay = Repay.new(repay_params)

    respond_to do |format|
      if @repay.save
        format.html { redirect_to reembolsos_path, notice: 'Repay was successfully created.' }
        format.json { render :show, status: :created, location: @repay }
      else
        format.html { render :new }
        format.json { render json: @repay.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /repays/1
  # PATCH/PUT /repays/1.json
  def update
    respond_to do |format|
      if @repay.update(repay_params)
        format.html { redirect_to reembolsos_path, notice: 'Repay was successfully updated.' }
        format.json { render :show, status: :ok, location: @repay }
      else
        format.html { render :edit }
        format.json { render json: @repay.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repays/1
  # DELETE /repays/1.json
  def destroy
    @repay.destroy
    respond_to do |format|
      format.html { redirect_to repays_url, notice: 'Repay was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_repay
      @repay = Repay.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def repay_params
      params.require(:repay).permit(:user_id, :description, :value, :kind, :status, :fiscal_note)
    end

    def check_for_director_access
      unless current_user.has_director_access?
        flash[:danger] = "Apenas diretores tem acesso à isso."
        redirect_to root_path
      end
    end
end
