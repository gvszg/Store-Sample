class Notification < ActiveRecord::Base
  scope :recent, lambda { order(id: :DESC) }

  belongs_to :item

  validates_presence_of :item_id, on: :create
  validates_presence_of :content_title, on: :create
  validates_presence_of :content_text, on: :create

  def send_content_pic
    self.item.cover.url
  end
end