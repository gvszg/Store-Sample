module Admin::OrdersHelper
  def paid_status(order)
    (order.is_paid) == true ? "完成付款" : "尚未付款"
  end

  def order_status(status)
    case status
    when "order_placed"
      return "新增訂單"
    when "item_shipping"
      return "已出貨"
    when "item_shipped"
      return "完成取貨"
    when "order_cancelled"
      return "訂單取消"
    end
  end

  def phone_number_looking(order)
    order.info.ship_phone
  end
end