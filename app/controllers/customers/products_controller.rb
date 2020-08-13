class Customers::ProductsController < ApplicationController
	def index
		@products = Product.all
	end

	def show
		@product = Product.find(params[:id])
		if customer_signed_in?
			@quantity = current_customer.cart_products.new
		end
	end

end