class CreateCartItems < ActiveRecord::Migration
  def change
    create_table :cart_items do |t|
      t.references :cart,  index: true
      t.references :item,  index: true
      t.integer    :quantity, default: 0
      t.decimal    :price, precision: 14, scale: 2, default: 0
      t.decimal    :total, precision: 14, scale: 2, default: 0
      t.timestamps null: false
    end
  end
end
