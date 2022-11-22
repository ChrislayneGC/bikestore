class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :user, index: true
      t.integer :items_count, default: 0
      t.decimal :total, default: 0
      t.timestamps null: false
    end
  end
end
