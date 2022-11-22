class AddNameToBanner < ActiveRecord::Migration
  def change
    add_column :banners, :name, :string
  end
end
