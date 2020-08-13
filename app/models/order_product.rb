class OrderProduct < ApplicationRecord
    belongs_to :order
    belongs_to :product

    enum status: {cannot_start:0, wait:1, production:2, complete: 3}

    require 'bigdecimal'
    def tax_price
    	(BigDecimal("#{price}") * BigDecimal("1.1")).ceil
    end

    def subtotal_price
    	self.tax_price.floor * quantity
    end
end
