# encoding: utf-8

class SpecPicUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
  
  # 預設圖片尺寸
  process resize_to_fit: [150, 150]
end