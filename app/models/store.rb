# == Schema Information
#
# Table name: stores
#
#  id         :integer          not null, primary key
#  county_id  :integer
#  town_id    :integer
#  road_id    :integer
#  store_type :integer
#  store_code :string(255)
#  name       :string(255)
#  address    :string(255)
#  phone      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  lat        :decimal(9, 7)
#  lng        :decimal(10, 7)
#

class Store < ActiveRecord::Base
  belongs_to :county
  belongs_to :town
  belongs_to :road
end
