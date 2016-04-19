# == Schema Information
#
# Table name: counties
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class County < ActiveRecord::Base
  has_many :towns
  has_many :stores
end
