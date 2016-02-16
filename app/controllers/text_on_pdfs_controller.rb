class TextOnPdfsController < ApplicationController
  before_action :set_text_on_pdf, only: [:show, :edit, :update, :destroy]

  # GET /text_on_pdfs
  # GET /text_on_pdfs.json
  def index
    @text_on_pdfs = TextOnPdf.all
  end

  # GET /text_on_pdfs/1
  # GET /text_on_pdfs/1.json
  def show
  end

  # GET /text_on_pdfs/new
  def new
    @text_on_pdf = TextOnPdf.new
    TextOnPdf.pdf_to_images
  end

  # GET /text_on_pdfs/1/edit
  def edit
  end

  # POST /text_on_pdfs
  # POST /text_on_pdfs.json
  def create
    @text_on_pdf = TextOnPdf.new(text_on_pdf_params)

    respond_to do |format|
      if @text_on_pdf.save
        format.html { redirect_to @text_on_pdf, notice: 'Text on pdf was successfully created.' }
        format.json { render :show, status: :created, location: @text_on_pdf }
      else
        format.html { render :new }
        format.json { render json: @text_on_pdf.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /text_on_pdfs/1
  # PATCH/PUT /text_on_pdfs/1.json
  def update
    respond_to do |format|
      if @text_on_pdf.update(text_on_pdf_params)
        format.html { redirect_to @text_on_pdf, notice: 'Text on pdf was successfully updated.' }
        format.json { render :show, status: :ok, location: @text_on_pdf }
      else
        format.html { render :edit }
        format.json { render json: @text_on_pdf.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /text_on_pdfs/1
  # DELETE /text_on_pdfs/1.json
  def destroy
    @text_on_pdf.destroy
    respond_to do |format|
      format.html { redirect_to text_on_pdfs_url, notice: 'Text on pdf was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_text_on_pdf
      @text_on_pdf = TextOnPdf.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def text_on_pdf_params
      params.require(:text_on_pdf).permit(:dir, :file_name, :original_dir, :original_file_name)
    end
end
