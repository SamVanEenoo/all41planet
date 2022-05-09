# app/uploaders
class ImageUploader < Shrine
  include MiniMagick
  Attacher.validate do
  # You can add your image validations here ..
  end

  Attacher.derivatives do |original|
    magick = ImageProcessing::MiniMagick.source(original)
    result = {}
    unless $logo_crop_x.blank?
      x = $logo_crop_x.to_f
      y = $logo_crop_y.to_f
      w = $logo_crop_w.to_f
      h = $logo_crop_h.to_f
      magick = magick.crop(x,y,w,h)
    end
    result[:thumb] = magick.resize_to_limit!(100, 100)
    result[:medium] = magick.resize_to_limit!(300, 300)
    result
  end

  class Attacher
    def promote(*)
      create_derivatives
      super
    end
  end
end
