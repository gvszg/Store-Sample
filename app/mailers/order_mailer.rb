class OrderMailer < ApplicationMailer
  def notify_order_placed(order)
    @order       = order
    @user        = order.user
    @order_items = @order.items
    @order_info  = @order.info
    mail(to: @order_info.ship_email , subject: "[萌萌屋] 感謝您完成本次的訂購)")
  end
end