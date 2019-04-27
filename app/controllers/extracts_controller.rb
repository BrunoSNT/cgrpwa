class ExtractsController < ApplicationController
  before_action :set_extract, only: [:show, :edit, :update, :destroy]
  before_action :check_for_director_access

  # GET /extracts
  # GET /extracts.json
  def index
    @main_page = "Admin"
    @page_title = "Extratos"
    @extracts = Extract.all
  end

  # GET /extracts/1
  # GET /extracts/1.json
  def show
  end

  # GET /extracts/new
  def new
    @main_page = "Admin"
    @page_title = "Novo Extrato"
    @extract = Extract.new
  end

  # GET /extracts/1/edit
  def edit
  end

  # POST /extracts
  # POST /extracts.json
  def create
    @extract = Extract.new(extract_params)

    respond_to do |format|
      if @extract.save
        format.html { redirect_to @extract, notice: 'Extract was successfully created.' }
        format.json { render :show, status: :created, location: @extract }
      else
        format.html { render :new }
        format.json { render json: @extract.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /extracts/1
  # PATCH/PUT /extracts/1.json
  def update
    respond_to do |format|
      if @extract.update(extract_params)
        format.html { redirect_to @extract, notice: 'Extract was successfully updated.' }
        format.json { render :show, status: :ok, location: @extract }
      else
        format.html { render :edit }
        format.json { render json: @extract.errors, status: :unprocessable_entity }
      end
    end
  end

  def money_flow
    @main_page = "Admin"
    @page_title = "Casa da Moeda"
    @exit_benefits = User.all.reduce(0) {|sum,user| user.beneficial_politics + sum}
    @exit = Repay.where(status: "pendente" ).reduce(0) {|sum, repay| repay.value + sum}
    @entry = Payment.where(status: ["a_receber","pendente","atrasado"] ).reduce(0) {|sum, pay| pay.value + sum}
  end
  

  # DELETE /extracts/1
  # DELETE /extracts/1.json
  def destroy
    @extract.destroy
    respond_to do |format|
      format.html { redirect_to extracts_url, notice: 'Extract was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extract
      @extract = Extract.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def extract_params
      params.require(:extract).permit(:user_id, :kind, :description, :value)
    end

    def check_for_director_access
      unless current_user.has_director_access?
        flash[:danger] = "Apenas diretores tem acesso à isso."
        redirect_to root_path
      end
    end
end
