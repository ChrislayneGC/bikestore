class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user,   index: true
      t.string     :number,  index: true
      t.string     :payment_method
      t.text       :payment_data
      t.integer    :payment_months
      t.string     :payment_status,     default: "waiting"
      t.string     :payment_invoice_id, index: true
      t.datetime   :delivered_in
      t.decimal    :total,   precision: 14, scale: 2, default: 0
      t.string     :slug, index: true
      t.timestamps null: false
      t.timestamps null: false
    end
  end
end
