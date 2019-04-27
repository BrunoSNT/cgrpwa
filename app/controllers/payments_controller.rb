class PaymentsController < ApplicationController
  before_action :set_payment, only: [:show, :edit, :update, :destroy, :update_payment_status]
  before_action :check_for_director_access

  def update_payment_status
    @payment.status = params[:status]
    respond_to do |format|
      if @payment.save
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
  # GET /payments
  # GET /payments.json
  def index
    @main_page = "Admin"
    @page_title = "Pagamentos"
    @payments = Payment.all
    @payment_status = Payment.statuses
  end

  # GET /payments/1
  # GET /payments/1.json
  def show
  end

  # GET /payments/new
  def new
    @main_page = "Admin"
    @page_title = "Nova Parcela"
    @payment = Payment.new
  end

  # GET /payments/1/edit
  def edit
    @main_page = "Admin"
    @page_title = "Editar Parcela"
  end

  # POST /payments
  # POST /payments.json
  def create
    @payment = Payment.new(payment_params)

    respond_to do |format|
      if @payment.save
        format.html { redirect_to payments_path, notice: 'Parcela criada.' }
        format.json { render :show, status: :created, location: @payment }
      else
        format.html { render :new }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /payments/1
  # PATCH/PUT /payments/1.json
  def update
    respond_to do |format|
      if @payment.update(payment_params)
        format.html { redirect_to payments_path, notice: 'Parcela atualizada.' }
        format.json { render :show, status: :ok, location: @payment }
      else
        format.html { render :edit }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /payments/1
  # DELETE /payments/1.json
  def destroy
    @payment.destroy
    respond_to do |format|
      format.html { redirect_to payments_url, notice: 'Payment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_payment
      @payment = Payment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def payment_params
      params.require(:payment).permit(:project_id, :value, :payment_date, :hour_report, :status)
    end

    def check_for_director_access
      unless current_user.has_director_access?
        flash[:danger] = "Apenas diretores tem acesso à isso."
        redirect_to root_path
      end
    end
end
