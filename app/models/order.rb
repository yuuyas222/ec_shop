class Order < ApplicationRecord
    has_many :order_products, dependent: :destroy
    has_many :products, through: :order_products

    belongs_to :customer

    enum payment: {'クレジットカード': 0, '銀行振込': 1}
    enum status: {wait:0, confirm:1, production:2, preparation: 3, complete: 4}
    # STATUS = {'入金待ち': 0, '入金確認': 1, '製作中': 2, '発送準備中': 3, '発送済み': 4}

    def total_quantity
    	orderProducts = order_products.all
    	total_quantity = 0
    	orderProducts.each do |order_product|
    		total_quantity += order_product.quantity
    	end
    	return total_quantity
    end
end
