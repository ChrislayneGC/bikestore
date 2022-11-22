class AddTextToItem < ActiveRecord::Migration
  def change
    add_column :items, :text, :text
  end
end
