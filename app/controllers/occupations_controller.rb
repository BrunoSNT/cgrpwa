class OccupationsController < ApplicationController
  before_action :set_occupation, only: [:show, :edit, :update, :destroy]
  before_action :check_for_director_access

  # GET /occupations
  # GET /occupations.json
  def index
    @main_page = "Admin"
    @page_title = "Cargos"
    @occupations = Occupation.all
  end

  # GET /occupations/1
  # GET /occupations/1.json
  def show
    @main_page = "Admin"
    @page_title = "Cargo"
  end

  # GET /occupations/new
  def new
    @main_page = "Admin"
    @page_title = "Novo Cargo"
    @occupation = Occupation.new
  end

  # GET /occupations/1/edit
  def edit
    @main_page = "Admin"
    @page_title = "Editar Cargo"
  end

  # POST /occupations
  # POST /occupations.json
  def create
    @occupation = Occupation.new(occupation_params)

    respond_to do |format|
      if @occupation.save
        format.html { redirect_to @occupation, notice: 'Cargo criado com sucesso.' }
        format.json { render :show, status: :created, location: @occupation }
      else
        format.html { render :new }
        format.json { render json: @occupation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /occupations/1
  # PATCH/PUT /occupations/1.json
  def update
    respond_to do |format|
      if @occupation.update(occupation_params)
        format.html { redirect_to @occupation, notice: 'Cargo atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @occupation }
      else
        format.html { render :edit }
        format.json { render json: @occupation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /occupations/1
  # DELETE /occupations/1.json
  def destroy
    @occupation.destroy
    respond_to do |format|
      format.html { redirect_to occupations_url, notice: 'Cargo deletado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_occupation
      @occupation = Occupation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def occupation_params
      params.require(:occupation).permit(:name, :description)
    end

    def check_for_director_access
      unless current_user.has_director_access?
        flash[:danger] = "Apenas diretores tem acesso à isso."
        redirect_to root_path
      end
    end
end
