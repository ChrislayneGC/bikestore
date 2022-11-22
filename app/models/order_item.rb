class OrderItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  validates :quantity, :price, :total, presence: true


  def to_gateway
    { description: description, quantity: quantity, price: (price * 100) }
  end
end
