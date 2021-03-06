class TextOnPdfsController < ApplicationController
  layout false, only: [:create]
  before_action :set_text_on_pdf, only: [:show, :edit, :update, :destroy]
  before_action :create_comments, only: [:new]

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
    TextOnPdf.destroy_all
    TextOnPdf.pdf_to_images
  end

  def generate_pdf

  end

  # GET /text_on_pdfs/1/edit
  def edit
  end

  # POST /text_on_pdfs
  # POST /text_on_pdfs.json
  def create
    @comments = Comment.where.not(body: '')

    respond_to do |format|
      original_orientation = TextOnPdf.first.original_orientation

      format.pdf do
        pdf = render_to_string pdf: 'generated_pdf.pdf',
                               template: 'text_on_pdfs/generated_pdf.pdf',
                               encording: 'UTF-8',
                               layout: 'pdf.html',
                               orientation: original_orientation,
                               show_as_html: true
                              #  show_as_html: params[:debug].present?
        send_data(pdf)
      end
    end
  end

  def rotate
    TextOnPdf.all.each do |text_on_pdf|
      text_on_pdf.rotate!
    end

    @text_on_pdf = TextOnPdf.new

    respond_to do |format|
      format.html { render new_text_on_pdf_path }
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

    def create_comments
      Comment.destroy_all
      Settings.num_comments_on_pdf.times.each do |i|
        Comment.create!(name: "comment#{i + 1}")
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def text_on_pdf_params
      params.require(:text_on_pdf).permit(:dir, :file_name, :original_dir, :original_file_name, :comment1_on_pdf, :comment2_on_pdf, :comment3_on_pdf, :comment4_on_pdf, :comment5_on_pdf)
    end

end
