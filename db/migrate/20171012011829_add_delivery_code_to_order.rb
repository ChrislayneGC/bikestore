class AddDeliveryCodeToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_code, :string
  end
end
