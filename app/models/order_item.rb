class OrderItem < ActiveRecord::Base
  belongs_to :order

  validates_presence_of :source_item_id, allow_blank: true
end