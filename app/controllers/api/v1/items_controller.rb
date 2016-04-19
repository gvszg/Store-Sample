class Api::V1::ItemsController < ApiController
  def index
    items = Item.includes(:photos, :specs, :item_categories, :categories).priority
    render json: items, only: [:id, :name, :price, :position]
  end

  def show
    item = Item.includes(:photos, :specs).find(params[:id])
    specs = item.specs
    on_shelf_specs = []
    specs.each do |spec|
      on_shelf_specs << spec if spec.status == "on_shelf"
    end

    result_item = {}
    result_item[:id] = item.id
    result_item[:name] = item.name
    result_item[:price] = item.price
    result_item[:cover] = item.cover.url
    result_item[:description] = item.description
    include_photos = []
    item.photos.each do |photo|
      pic = {}
      pic[:image_url] = photo.image.url
      pic[:photo_intro] = photo.photo_intro
      include_photos << pic
    end
    result_item[:photos] = include_photos

    include_specs = []
    
    # specs.map {|spec| spec if spec.status == 0}
    if on_shelf_specs.count >= 1
      on_shelf_specs.each do |spec|
        spec_hash = {}
        spec_hash[:id] = spec.id
        spec_hash[:style] = spec.style
        spec_hash[:amount] = spec.style_amount
        spec_hash[:pic] = spec.style_pic.url
        include_specs << spec_hash
      end
      result_item[:specs] = include_specs
    else
      result_item[:specs] = ""
    end
    
    render json: result_item
  end

  def spec_info
    item = Item.includes(:photos, :specs).find(params[:id])
    specs = item.specs
    on_shelf_specs = []
    specs.each do |spec|
      on_shelf_specs << spec if spec.status == "on_shelf"
    end

    result_spec_infos = []
    on_shelf_specs.each do |spec|
      spec_hash = {}
      spec_hash[:id] = spec.id
      spec_hash[:style] = spec.style
      spec_hash[:style_amount] = spec.style_amount
      spec_hash[:style_pic] = spec.style_pic.url
      result_spec_infos << spec_hash
    end

    render json: result_spec_infos
  end
end