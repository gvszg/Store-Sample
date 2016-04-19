class Admin::OrdersController < AdminController
  before_action :require_manager
  before_action :find_order, only: [:show, :order_processing, :item_shipping, :item_shipped, :order_cancelled]

  def index
    @order_page = @orders = Order.includes(:user, :info, :items).recent.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.json { render json: @orders, only: [:id, :user_id, :uid, :total, :is_paid, :status, :payment_method, :ship_fee, :items_price] }
    end
  end

  def show    
    @info = @order.info
    @items = @order.items

    respond_to do |format|
      format.html
      format.json { render json: @order }
    end
  end

  def order_processing
    begin
      @order.update_attributes!(status: 1)      
    rescue ActiveRecord::ActiveRecordError
      flash[:alert] = "請仔細確認訂單的實際處理進度"
    end

    respond_to do |format|
      format.html do
        flash[:notice] = "已將編號：#{@order.id} 訂單狀態設為處理中"
        redirect_to :back
      end

      format.js
    end
  end

  def item_shipping
    begin
      @order.update_attributes!(status: 2)      
    rescue ActiveRecord::ActiveRecordError
      flash[:alert] = "請仔細確認訂單的實際處理進度"
    end

    respond_to do |format|
      format.html do
        flash[:notice] = "已將編號：#{@order.id} 訂單狀態設為已出貨"
        redirect_to :back
      end

      format.js
    end
  end

  def item_shipped
    begin
      @order.update_attributes!(status: 3)      
    rescue ActiveRecord::ActiveRecordError
      flash[:alert] = "請仔細確認訂單的實際處理進度"
    end

    respond_to do |format|
      format.html do
        flash[:notice] = "已將編號：#{@order.id} 訂單狀態設為完成取貨"
        redirect_to :back
      end

      format.js
    end
  end

  def order_cancelled
    begin
      @order.update_attributes!(status: 4)      
    rescue ActiveRecord::ActiveRecordError
      flash[:alert] = "請仔細確認訂單的實際處理進度"
    end

    respond_to do |format|
      format.html do
        flash[:alert] = "已將編號：#{@order.id} 訂單狀態設為訂單取消"
        redirect_to :back
      end

      format.js
    end
  end

  def exporting_files
    @order_for_file_page = @orders_for_file = Order.includes(:user, :info).recent.paginate(:page => params[:page])

    respond_to do |format|
      format.html
      format.csv { send_data @orders_for_file.to_csv }
    end
  end

  private

  def find_order
    @order = Order.includes(:user, :info, :items).find(params[:id])
  end
end