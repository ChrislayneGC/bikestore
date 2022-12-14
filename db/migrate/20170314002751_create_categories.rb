class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.boolean :active
      t.string  :slug, index: true
      t.timestamps null: false
    end
  end
end
