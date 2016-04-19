class DeviceRegistration < ActiveRecord::Base
  validates_presence_of :registration_id, on: :create, message: "裝置ID不得空白"
  validates_uniqueness_of :registration_id, on: :create, message: "裝置ID重複了"
end