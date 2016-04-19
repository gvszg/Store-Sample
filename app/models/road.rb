# == Schema Information
#
# Table name: roads
#
#  id         :integer          not null, primary key
#  town_id    :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Road < ActiveRecord::Base
  belongs_to :town
  has_many :stores
end
