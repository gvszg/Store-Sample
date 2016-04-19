# == Schema Information
#
# Table name: item_categories
#
#  id          :integer          not null, primary key
#  item_id     :integer
#  category_id :integer
#  deleted_at  :datetime
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class ItemCategory < ActiveRecord::Base
  belongs_to :item
  belongs_to :category
end
