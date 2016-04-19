# encoding: utf-8

class ItemCoverUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 封面圖片尺寸
  process resize_to_fit: [450,300]

  # icon尺寸
  version :icon do
    process resize_to_fill: [150,100]
  end
end
