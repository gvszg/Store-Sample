class Staff::ItemSpecsController < StaffController
  before_action :require_assistant
  before_action :find_item
  before_action :find_spec, only: [:edit, :update, :destroy, :on_shelf, :off_shelf]

  def index
    @item_specs = @item.specs
  end

  def new
    @item_spec = @item.specs.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @item_spec = @item.specs.new(spec_params)

    respond_to do |format|
      if  @item_spec.save!
        format.html do
          flash[:notice] = "成功新增樣式"
          redirect_to staff_item_item_specs_path(@item)
        end

        format.js
      else
        format.html do
          flash[:alert] = "請確認所有欄位資料是否正確"
          render :new
        end
      end
    end
  end

  def edit
  end

  def update
    @item_spec.update!(update_spec_params)

    respond_to do |format|
      format.html do
        if @item_spec.valid?
          flash[:notice] = "編輯完成"
          redirect_to staff_item_item_specs_path(@item)
        else
          flash.now[:alert] = "請確認編輯內容是否正確"
          render :edit
        end
      end

      format.js
    end
  end

  def destroy
    @item_spec.destroy!
    flash[:warning] = "樣式圖片已刪除"
    redirect_to staff_item_item_specs_path(@item)
  end

  private

  def find_item
    @item = Item.includes(:specs).find(params[:item_id])
  end

  def find_spec
    @item_spec = @item.specs.find(params[:id])
  end

  def spec_params
    params.require(:item_spec).permit(:style, :style_pic, :style_amount)
  end

  def create_spec_params
    params.require(:item_spec).permit(:style, :style_pic, :style_amount).merge!(images: params[:images])
  end

  def update_spec_params
    params.require(:item_spec).permit(:style, :style_pic, :style_amount)
  end
end