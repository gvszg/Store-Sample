# == Schema Information
#
# Table name: managers
#
#  id              :integer          not null, primary key
#  username        :string(255)
#  email           :string(255)
#  password_digest :string(255)
#  status          :integer          default(0)
#  position        :integer          default(0)
#  deleted_at      :datetime
#  created_at      :datetime
#  updated_at      :datetime
#

class Manager < ActiveRecord::Base
  scope :recent, lambda { order(id: :DESC) }

  scope :priority, lambda { order(position: :ASC) }

  enum status: { confirmed: 0, denied: 1 }

  acts_as_paranoid

  has_secure_password
end