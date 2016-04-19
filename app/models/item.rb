# == Schema Information
#
# Table name: items
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  price       :integer          not null
#  slug        :string(255)
#  status      :integer          default(0)
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  description :text(65535)
#  cover       :string(255)
#  position    :integer          default(1)
#  url         :string(255)
#

class Item < ActiveRecord::Base
  scope :recent, lambda { order(id: :DESC) }

  scope :priority, lambda { order(position: :ASC) }

  enum status: { on_shelf: 0, off_shelf: 1 }

  acts_as_paranoid

  self.per_page = 15

  has_many :photos, dependent: :destroy
  has_many :item_categories
  has_many :categories, through: :item_categories
  has_many :specs, class_name: "ItemSpec", dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates_presence_of :name, :price, :description
  validates_numericality_of :price, only_integer: true, greater_than: 0

  mount_uploader :cover, ItemCoverUploader

  # 封面圖
  def intro_cover
    cover
  end

  def self.search_by_name(search_term)
    return [] if search_term.blank?
    where("name LIKE ?", "%#{search_term}%").recent
  end
end