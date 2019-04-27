class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @main_page = "Pessoal"
    @page_title = "Projetos"
    @projects = Project.all
    @current_projects = Project.current_projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    # COMENTÁRIO: O build inicializa a página com 1 nested já renderizado    
    @user_project = @project.user_projects.build 
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)

    if params["project"]["client_id"] != ""
      @project.client = Client.find params["project"]["client_id"]
    end

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Novo projeto cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_update_params)
        format.html { redirect_to @project, notice: 'Projeto atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Projeto deletado.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :description, :client_id, :enddate, :start_date, :avatar, :price, client_attributes: [:name, :social_reason, :client_email, :phone, :cpf], user_projects_attributes: [:id, :user_id, :role_id, :_destroy])
    end

    def project_update_params
      params.require(:project).permit(:name, :description, :client_id, :enddate, :start_date, :avatar, :price, user_projects_attributes: [:id, :user_id, :role_id, :_destroy])
    end
end
