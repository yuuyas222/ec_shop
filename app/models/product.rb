class Product < ApplicationRecord
	belongs_to :genre
	has_many :order_products
	has_many :cart_products

	attachment :image

	require 'bigdecimal'
    def tax_price
    	(BigDecimal("#{price}") * BigDecimal("1.1")).ceil
    end



end
