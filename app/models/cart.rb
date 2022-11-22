class Cart < ActiveRecord::Base
  belongs_to :user
  has_many :items, class_name: 'CartItem', dependent: :destroy

  validates :user, presence: true

  def push(params)
    return false unless params[:items].any?
    params[:items].each do |item|
      items.build(item_id: item[:id], quantity: item[:quantity] || 1)
    end
    save ? self : false
  end

  def remove(params)
    return false unless params[:items].any?
    removing = items.where(id: params[:items].collect{|i| i[:id] })
    items.delete(removing)
    save ? self : false
  end

  def update(params)
    return false unless params[:items].any?
    params[:items].each do |i|
      item = items.find_by_id(i[:id])
      item && item.update_attributes(quantity: i[:quantity])
    end
    save ? self : false
  end

  def item_available?(cart_item_id, quantity)
    cart_item = items.find_by_id(cart_item_id)
    item = Item.find(cart_item.item_id)
    response = { available: item.quantity >= quantity.to_i, max_amount: item.quantity }
    return response
  end

  def finish
    order = user.orders.new(total: self.total, payment_status: 'cart', payment_method: "not selected")
    items.each do |i|
      order.items.build(item_id: i.item_id, quantity: i.quantity, price: i.price, total: i.total)
    end
    order.save
  end

  def to_api
    { id: id, items: items.collect(&:to_api), count: items.count, ftotal: total.to_s, total: total.reais_contabeis }
  end

  after_save do |c|
    c.update_columns(items_count: c.items.size, total: c.items.collect(&:total).sum)
  end

end
