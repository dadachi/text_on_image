json.array!(@text_on_pdfs) do |text_on_pdf|
  json.extract! text_on_pdf, :id, :dir, :file_name, :original_dir, :original_file_name
  json.url text_on_pdf_url(text_on_pdf, format: :json)
end
