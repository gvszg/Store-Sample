class Api::V2::OrdersController < ApiController
  # TODO 重構整理
  def index
    orders = Order.includes(:user, :info, :items).all.page(params[:page]).per_page(20)
    render json: orders, only: [:id, :user_id, :total, :status, :uid]
  end

  def show
    order = Order.includes(:user, :info, :items).find(params[:id])
    info = order.info
    items = order.items
    result_order = order.generate_result_order(order, info, items)
    render json: result_order
  end

  def user_owned_orders
    user_orders = Order.includes(:user).where("uid = ?", params[:uid]).page(params[:page]).per_page(20)
    # result_user_orders = []

    render json: user_orders, only: [:id, :uid, :total, :created_on, :status, :user_id]
  end
end