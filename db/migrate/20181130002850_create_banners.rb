class CreateBanners < ActiveRecord::Migration
  def change
    create_table :banners do |t|
      t.boolean :active

      t.timestamps null: false
    end
  end
end
