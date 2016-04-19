# == Schema Information
#
# Table name: photos
#
#  id          :integer          not null, primary key
#  item_id     :integer
#  image       :string(255)
#  deleted_at  :datetime
#  created_at  :datetime
#  updated_at  :datetime
#  photo_intro :string(255)
#

class Photo < ActiveRecord::Base
  # acts_as_paranoid
  
  belongs_to :item

  mount_uploader :image, ImageUploader
end