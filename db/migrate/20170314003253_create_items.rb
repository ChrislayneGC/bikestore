class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.decimal :weight
      t.decimal :height
      t.decimal :length
      t.decimal :width
      t.boolean :active
      t.string :description
      t.references :subcategory, index: true
      t.string  :slug, index: true
      t.timestamps null: false
    end
    add_attachment :items, :image
  end
end
