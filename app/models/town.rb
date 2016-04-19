# == Schema Information
#
# Table name: towns
#
#  id         :integer          not null, primary key
#  county_id  :integer
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Town < ActiveRecord::Base
  belongs_to :county
  has_many :roads
  has_many :stores
end
