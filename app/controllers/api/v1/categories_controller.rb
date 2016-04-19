class Api::V1::CategoriesController < ApiController
  # TODO 整理至model
  def index
    # TODO 分批撈資料
    categories = Category.all
    # categories = Category.includes(:item_categories, items: [:photos]).all
    
    render json: categories, only: [:id, :name]
  end

  def show
    # category = Category.includes(:item_categories, :items).find(params[:id])

    # 先將商品與相關圖片讀取好
    category = Category.includes(:items).find(params[:id])
    # TODO 商品封面圖只傳預設尺寸
    items = category.items.priority.select(:id, :name, :price, :cover, :position).where("status = ?", "0").uniq.page(params[:page]).per_page(20)

    # result_category = {}
    # include_items = []
    # items = category.items.select(:id, :name, :price, :cover).where("status = ?", "0").uniq.page(params[:page]).per_page(20)
    # items.each do |item|
    #   item_hash = {}
    #   item_hash[:id] = item.id
    #   item_hash[:name] = item.name
    #   item_hash[:price] = item.price
    #   item_hash[:cover] = item.photos.first.image.url
    #   include_items << item_hash
    # end
    # result_category = include_items
    # render json: result_category
    render json: items
  end
end