class TextOnPdf < ActiveRecord::Base

  attr_accessor :comment1_on_pdf
  attr_accessor :comment2_on_pdf
  attr_accessor :comment3_on_pdf
  attr_accessor :comment4_on_pdf
  attr_accessor :comment5_on_pdf

  def self.pdf_to_images
    pdf = Magick::ImageList.new(Rails.root.join('public/pdfs/pdf_sample.pdf'))

    pdf.each_with_index do |page_img, i|
      page_img.write Rails.root.join("public/images/pdf_sample_#{i}.jpg")
    end
  end

  def self.test_text_on_image
    # img = Magick::ImageList.new('public/images/pdf_sample_0.jpg')
    # txt = Magick::Draw.new
    #
    # canvas = Magick::ImageList.new
    # canvas.new_image(300, 100, Magick::TextureFill.new(granite))
    #
    # text = Magick::Draw.new
    # text.font_family = 'helvetica'
    # text.pointsize = 52
    # text.gravity = Magick::CenterGravity
    #
    # img.annotate(canvas, 0,0,0,0, "In ur Railz, annotatin ur picz.") {
    #   self.fill = 'gray83'
    #   # txt.gravity = Magick::SouthGravity
    #   # txt.pointsize = 25
    #   # txt.stroke = '#000000'
    #   # txt.fill = '#ffffff'
    #   # txt.font_weight = Magick::BoldWeight
    # }

    # txt.gravity = Magick::SouthGravity
    # txt.pointsize = 25
    # txt.stroke = '#000000'
    # txt.fill = '#ffffff'
    # txt.font_weight = Magick::BoldWeight

    img = Magick::ImageList.new('public/images/pdf_sample_0.jpg')
    txt = Magick::Draw.new
    img.annotate(txt, 0,0,0,0, "The text you want to add in the image"){
      self.font_family = 'Arial'
      self.fill = 'white'
      self.pointsize = 32
    }

    img.format = ‘jpeg’

    # send_data img.to_blob, :stream => ‘false’, :filename => ‘test.jpg’, :type => ‘image/jpeg’, :disposition => ‘inline’
    img.write Rails.root.join("public/text_on_images/pdf_sample_0.jpg")
  end
end
