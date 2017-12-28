class ImageUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick
  storage :fog
  version :thumb_1x do
    process :resize_to_fill => [32,32]
  end

  def store_dir
    "#{model.class.to_s.underscore}/file/#{("%04d" % model.id)}"
  end
 
end
