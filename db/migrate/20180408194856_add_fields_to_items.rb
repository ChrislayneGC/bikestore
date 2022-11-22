class AddFieldsToItems < ActiveRecord::Migration
  def change
    add_column :items, :highlight, :boolean, default: :false
  end
end
