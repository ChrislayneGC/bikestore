class CreateItemImages < ActiveRecord::Migration
  def change
    create_table :item_images do |t|
      t.string :name
      t.references :item, index: true
      t.string  :slug, index: true
      t.timestamps null: false
    end
    add_attachment :item_images, :image
  end
end
