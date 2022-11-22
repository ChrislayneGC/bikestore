class CreateOrderItems < ActiveRecord::Migration
  def change
    create_table :order_items do |t|
      t.references :order, index: true
      t.references :item,  index: true
      t.integer :quantity, default: 0
      t.decimal :price, precision: 14, scale: 2, default: 0
      t.decimal :total, precision: 14, scale: 2, default: 0
      t.timestamps null: false
    end
  end
end
