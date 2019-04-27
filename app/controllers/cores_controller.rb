class CoresController < ApplicationController
  before_action :set_core, only: [:show, :edit, :update, :destroy]
  before_action :check_for_director_access

  # GET /cores
  # GET /cores.json
  def index
    @main_page = "Admin"
    @page_title = "Núcleos"
    @cores = Core.all
  end

  # GET /cores/1
  # GET /cores/1.json
  def show
    @main_page = "Admin"
    @page_title = "Núcleo"
  end

  # GET /cores/new
  def new
    @main_page = "Admin"
    @page_title = "Novo Núcleo"
    @core = Core.new
  end

  # GET /cores/1/edit
  def edit
    @main_page = "Admin"
    @page_title = "Editar Núcleo"
  end

  # POST /cores
  # POST /cores.json
  def create
    @core = Core.new(core_params)

    respond_to do |format|
      if @core.save
        format.html { redirect_to @core, notice: 'Núcleo criado com sucesso.' }
        format.json { render :show, status: :created, location: @core }
      else
        format.html { render :new }
        format.json { render json: @core.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cores/1
  # PATCH/PUT /cores/1.json
  def update
    respond_to do |format|
      if @core.update(core_params)
        format.html { redirect_to @core, notice: 'Núcleo atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @core }
      else
        format.html { render :edit }
        format.json { render json: @core.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cores/1
  # DELETE /cores/1.json
  def destroy
    @core.destroy
    respond_to do |format|
      format.html { redirect_to cores_url, notice: 'Núcleo deletado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_core
      @core = Core.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def core_params
      params.require(:core).permit(:name, :description, :initial)
    end

    def check_for_director_access
      unless current_user.has_director_access?
        flash[:danger] = "Apenas diretores tem acesso à isso."
        redirect_to root_path
      end
    end
end
