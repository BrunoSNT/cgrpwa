class DiretorProjectsController < ApplicationController

  # GET /projects
  # GET /projects.json
  def index
    @main_page = "Admin"
    @page_title = "Projetos em andamento"
    @current_projects = Project.current_projects

    unless current_user.has_director_access?
      flash[:danger] = "Apenas diretores tem acesso ao dashboard de projetos."
      redirect_to projects_path
    end
  end
end
