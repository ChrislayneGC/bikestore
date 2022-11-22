class CreateOrderShippings < ActiveRecord::Migration
  def change
    create_table :order_shippings do |t|
      t.references :order, index: true, index: true
      t.string :kind
      t.string :street
      t.string :district
      t.string :number
      t.string :zipcode
      t.string :city
      t.string :state
      t.string :country, default: "Brasil"
      t.float :latitude
      t.float :longitude
      t.float :value
      t.string :status, index: true
      t.timestamps null: false
    end
  end
end
