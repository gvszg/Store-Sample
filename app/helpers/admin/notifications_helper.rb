module Admin::NotificationsHelper
  def notification_photo(notification, size=nil)
    if notification.present?
      if size.present?
        image_url = notification.content_pic.send(size).url
      else        
        image_url = notification.content_pic.url
      end
    else
      case size
      when :thumb
        volume = "150x100"
      else
        volume = "600x400"
      end

      image_url = "http://placehold.it/#{volume}&text=No Pic"
    end

    image_tag(image_url, :class => "thumbnail")
  end
end