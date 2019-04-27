class DocumentsController < ApplicationController
  def index
    @main_page = "Pessoal"
    @page_title = "Documentos"
    @documents = Document.all
  end
  
  def new
    @main_page = "Pessoal"
    @page_title = "Novo Documento"
    @document = Document.new
  end
  
  def create
    @document = Document.new(document_params)
    
    if @document.save
      redirect_to documents_path, notice: "The document #{@document.name} has been uploaded."
    else
      render "new"
    end
  end
  
  def destroy
    @document = Document.find(params[:id])
    @document.destroy
    redirect_to documents_path, notice:  "The document #{@document.name} has been deleted."
  end
  
  private
    def document_params
    params.require(:document).permit(:name, :file)
  end
end
