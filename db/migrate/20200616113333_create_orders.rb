class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :customer_id, null: false
      t.integer :shippings, null: false, default: 800
      t.integer :total_price, null: false
      t.integer :status, null: false, default: 0
      t.string :shipping_name, null: false
      t.string :shipping_postcode, null: false
      t.string :shipping_address, null: false
      t.integer :payment, null: false

      t.timestamps
    end
  end
end
