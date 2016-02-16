class TextOnPdf < ActiveRecord::Base
  # require 'RMagick'

  def self.pdf_to_images
    pdf = Magick::ImageList.new(Rails.root.join('public/pdfs/pdf_sample.pdf'))

    pdf.each_with_index do |page_img, i|
      page_img.write Rails.root.join("public/images/pdf_sample_#{i}.jpg")
    end
  end

end
