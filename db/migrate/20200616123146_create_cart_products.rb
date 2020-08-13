class CreateCartProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :cart_products do |t|
      t.integer :customer_id, null: false
      t.integer :product_id, null: false
      t.integer :quantity, null: false, default: 1

      t.timestamps
    end
  end
end
