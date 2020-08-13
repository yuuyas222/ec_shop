class Admins::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order_products = @order.order_products.all
  end

  # 制作ステータス
  def update
    order = Order.find(params[:id])
    order.status = params[:order][:status].to_i
    order.update(update_params)
    redirect_to admins_order_path(order)
  end

  private
    def update_params
        params.require(:order).permit(:status)
    end
end
