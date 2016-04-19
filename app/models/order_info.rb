# == Schema Information
#
# Table name: order_infos
#
#  id              :integer          not null, primary key
#  order_id        :integer
#  ship_name       :string(255)
#  ship_address    :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  ship_store_code :integer
#  ship_phone      :string(255)
#  ship_store_id   :integer
#  ship_store_name :string(255)
#

class OrderInfo < ActiveRecord::Base
  belongs_to :order
end
