class CartProduct < ApplicationRecord
	belongs_to :customer
	belongs_to :product


	require 'bigdecimal'
    def tax_price
    	(BigDecimal("#{product.price}") * BigDecimal("1.1")).ceil
    end

	def subtotal_price
		self.tax_price * quantity
	end
end
