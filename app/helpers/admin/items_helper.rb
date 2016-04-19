module Admin::ItemsHelper
  def item_title
    action_name == "new" ? "新增商品" : "編輯商品"
  end

  def item_icon(photo)
    if photo.present?
      image_url = photo.icon.url
    else
      image_url = "http://placehold.it/150x100&text=No Pic"      
    end
    
    image_tag(image_url, class: "thumbnail")
  end

  def item_cover(photo)
    if photo.present?
      image_url = photo.url
    else
      image_url = "http://placehold.it/450x300&text=No Pic"      
    end
    
    image_tag(image_url, class: "thumbnail")
  end

  def item_photo(photo, size=nil)
    if photo.present?
      if size.present?
        image_url = photo.image.send(size).url
      else        
        image_url = photo.image.url
      end
    else
      case size
      when :cover
        volume = "450x300"
      when :thumb
        volume = "150x100"
      else
        volume = "600x400"
      end

      image_url = "http://placehold.it/#{volume}&text=No Pic"
    end

    image_tag(image_url, :class => "thumbnail")
  end

  def spec_photo(spec)
    if spec.style_pic.present?
      image_url = spec.style_pic.url
    else
      image_url = "http://placehold.it/150x150&text=No Pic"
    end

    image_tag(image_url, :class => "thumbnail")
  end

  def show_item_stock(amount)
    amount == 0 ? "無庫存" : amount
  end

  def item_status(status)
    case status
    when "on_shelf"
      return "上架中"
    when "off_shelf"
      return "已下架" 
    end
  end

  def spec_status(status)
    case status
    when "on_shelf"
      return "上架中"
    when "off_shelf"
      return "已下架" 
    end
  end
end