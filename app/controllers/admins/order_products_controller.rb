class Admins::OrderProductsController < ApplicationController
  before_action :authenticate_admin!

  # 注文ステータスの更新
  def update
    order_product = OrderProduct.find(params[:id])
    order_product.update(update_params)
    redirect_to admins_order_path(order_product.order_id)
  end

  private
    def update_params
        params.require(:order_product).permit(:status)
    end
end
