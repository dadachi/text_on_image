class AddHeightToTextOnPdfs < ActiveRecord::Migration
  def change
    add_column :text_on_pdfs, :height, :integer, after: :original_file_name
    add_column :text_on_pdfs, :width, :integer, after: :height
    add_column :text_on_pdfs, :original_height, :integer, after: :width
    add_column :text_on_pdfs, :original_width, :integer, after: :original_height
  end
end
