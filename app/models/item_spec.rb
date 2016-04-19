# == Schema Information
#
# Table name: item_specs
#
#  id           :integer          not null, primary key
#  item_id      :integer
#  style        :string(255)
#  style_amount :integer
#  style_pic    :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  deleted_at   :datetime
#  status       :integer          default(0)
#

class ItemSpec < ActiveRecord::Base
  scope :recent, -> {order(id: :DESC)}

  enum status: { on_shelf: 0, off_shelf: 1 }

  acts_as_paranoid

  belongs_to :item

  # validates_presence_of :style, :style_amount
  validates_numericality_of :style_amount, :only_integer => true, :greater_than_or_equal_to => 0, :allow_blank => true

  mount_uploader :style_pic, SpecPicUploader
end