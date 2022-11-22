class AddComplementToOrderShipping < ActiveRecord::Migration
  def change
  	add_column :order_shippings, :complement, :string
  end
end
