class CreateDestinations < ActiveRecord::Migration[5.2]
  def change
    create_table :destinations do |t|
      t.integer :customer_id, null: false
      t.string :name, null: false
      t.string :postcode, null: false
      t.string :address, null: false

      t.timestamps
    end
  end
end
