class CreateSubcategories < ActiveRecord::Migration
  def change
    create_table :subcategories do |t|
      t.string :name
      t.boolean :active
      t.references :category, index: true
      t.string  :slug, index: true
      t.timestamps null: false
    end
  end
end
