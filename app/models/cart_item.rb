class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item

  private

  before_save do |i|
    i.price, i.total = i.item.price.to_f, (i.item.price.to_f * i.quantity.to_i)
  end
end
