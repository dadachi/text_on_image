WickedPdf.config = {
  #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
  #:layout => "pdf.html",
  :exe_path => "#{Gem.loaded_specs['wkhtmltopdf-binary'].full_gem_path}/bin/wkhtmltopdf"
}
