class TextOnPdf < ActiveRecord::Base

  attr_accessor :comment1_on_pdf
  attr_accessor :comment2_on_pdf
  attr_accessor :comment3_on_pdf
  attr_accessor :comment4_on_pdf
  attr_accessor :comment5_on_pdf

  def self.pdf_to_images
    # http://stackoverflow.com/questions/16168798/low-quality-when-converting-pdf-to-jpg
    # http://stackoverflow.com/questions/32122710/rails-rmagick-converted-image-turns-solid-black-when-resize-to-fit-applied
    pdf = Magick::ImageList.new(Rails.root.join('public/pdfs/pdf_sample.pdf')) do
      self.quality = 80
      self.density = '300'
      self.colorspace = Magick::RGBColorspace
      self.interlace = Magick::NoInterlace
    end

    pdf.each_with_index do |page_img, i|
      page_img.format = 'JPEG'
      page_img.alpha(Magick::DeactivateAlphaChannel)
      page_img.resize_to_fit!(800, 800)
      page_img.write Rails.root.join("public/images/pdf_sample_#{i}.jpg")

      TextOnPdf.create!(original_dir: 'public/pdfs',
        original_file_name: 'pdf_sample.pdf',
        dir: 'public/images',
        file_name: "pdf_sample_#{i}.jpg",
        original_width: page_img.columns,
        original_height: page_img.rows
      )
    end
  end

  def rotate!
    if width.blank? || height.blank?
      self.width = original_height
      self.height = original_width
    else
      tmp_width = width
      self.width = height
      self.height = tmp_width
    end
    save!

    images = Magick::Image.read(Rails.root.join("#{dir}/#{file_name}"))
    rotated_image = images[0].rotate(90)
    rotated_image.write Rails.root.join("#{dir}/#{file_name}")
  end

  def original_orientation
    if original_width <= original_height
      'Portrait'
    else
      'Landscape'
    end
  end

  def orientation
    return nil if width.blank? || height.blank?
    if width <= height
      'Portrait'
    else
      'Landscape'
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
