class Customers::OrdersController < ApplicationController
    before_action :authenticate_customer!

    def index
        @orders = current_customer.orders.all
    end

    def new
        # 支払い方法入力するため記載
        @order = Order.new
    end

    def confirm
        # 注文商品を全て表示するために記載
        @orders = current_customer.cart_products.all
        @order = Order.new(order_params)
        if params[:select_radio] == "1"
            @order.shipping_postcode = current_customer.postcode
            @order.shipping_address = current_customer.address
            @order.shipping_name = current_customer.family_name + current_customer.first_name
            @order.payment = params[:order][:payment]
        elsif params[:select_radio] == "2"
            @destination = Destination.find(params[:order][:select_destinations])
            @order.shipping_postcode = @destination.postcode
            @order.shipping_address = @destination.address
            @order.shipping_name = @destination.name
            @order.payment = params[:order][:payment]
        elsif params[:select_radio] == "3"
            @order.shipping_postcode = params[:order][:shipping_postcode]
            @order.shipping_address = params[:order][:shipping_address]
            @order.shipping_name = params[:order][:shipping_name]
            @order.payment = params[:order][:payment]
        end
    end

    def create
        #既に登録済みのデータと新規入力情報
        @order = current_customer.orders.new(order_params)
        cart_products = current_customer.cart_products.all
        if @order.save
            destination = current_customer.destinations.new(destination_params)
            destination.postcode = params[:order][:shipping_postcode]
            destination.address = params[:order][:shipping_address]
            destination.name = params[:order][:shipping_name]
            destination.save
            cart_products.each do |cart_product|
                order_product = OrderProduct.new(order_products_params)
                order_product.product_id = cart_product.product_id
                order_product.order_id = @order.id
                order_product.quantity = cart_product.quantity
                product = Product.find(cart_product.product_id)
                order_product.price = product.price
                order_product.save
            end
            cart_products.destroy_all
            redirect_to orders_thanks_path
        end
    end

    def thanks
    end

    def show
        @order = Order.find(params[:id])
        @order_products = OrderProduct.where(order_id: @order.id)
    end

    private

    def order_params
    params.require(:order).permit(:total_price, :status, :shipping_name, :shipping_postcode, :shipping_address, :payment)
    end

    def order_products_params
        params.require(:order).permit(:quantity, :price)
    end

    def destination_params
        params.require(:destination).permit(:postcode, :address, :name)
    end

end