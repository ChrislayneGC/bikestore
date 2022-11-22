# encoding: utf-8
class Order < ActiveRecord::Base
  extend FriendlyId
  friendly_id :number, use: [:slugged, :finders]

  belongs_to :user

  has_many   :items,    class_name: 'OrderItem'
  has_one    :shipping, class_name: 'OrderShipping'

  scope :has_billet, -> { where.not(gateway_url: "") }

  validates :user, presence: true

  accepts_nested_attributes_for :shipping, allow_destroy: true
  accepts_nested_attributes_for :items,    allow_destroy: true

  def self.create_from_cart(cart)
    user = cart.user
    if cart.items.any?
      order = user.orders.build
      # BUILD ORDER ITEMS
      cart.items.each do |product|
        order.items.build(item_id: product.item_id, quantity: product.quantity, price: product.price, total: product.total)
      end
      # BUILD SHIPPING ADDRESS
      address = (user.addresses.shipping[0] or user.addresses[0])
      order.build_shipping(address.attributes.except('id', 'user_id', 'active', 'created_at', 'updated_at')) if(address.present?)
      order.save ? (cart.destroy; order) : false
    else
      false
    end
  end

  def generate_billet(url, id)
    self.billet_url = url
    self.payment_invoice_id = id
    self.save
    self
  end

  def pay_with_credit_card(cc)
    response = MundiPagg.charge_credit_card( (total_with_shipping * 100).to_i, cc)
    raise response.inspect
    raise response.inspect
    if !response["ErrorReport"].present? && response["CreditCardTransactionResultCollection"][0]["Success"]
      self.status = "paid"
      self.save
      raise cc.inspect
    else
      raise response.inspect
    end
  end

  def total_with_shipping
    return self.shipping.present? ? (self.total.to_f + self.shipping.value.to_f) : self.total.to_f
  end

  def freight_dimensions
    dimensions = {length: 0, width: 0, weight: 0, height: 0}
    self.items.each do |item|
      dimensions[:length] += item.item.length
      dimensions[:width] += item.item.width
      dimensions[:weight] += item.item.weight
      dimensions[:height] += item.item.height
    end
    return dimensions
  end

  def generate_freight
    dimensions = freight_dimensions
    return Freight.calculate(self.shipping.zipcode, "83323-090", dimensions[:weight], dimensions[:width], dimensions[:height], dimensions[:length])
  end

  def generate_sedex
    options = generate_freight
    self.shipping.value = options[:sedex].valor
    self.shipping.kind = "SEDEX"
    self.total += self.shipping.value
    self.save
  end

  def generate_pac
    options = generate_freight
    self.shipping.value = options[:pac].valor
    self.shipping.kind = "PAC"
    self.total += self.shipping.value
    self.save
  end


  def self.create_from_cart_no_destroy(cart)
    user = cart.user
    if cart.items.any?
      order = user.orders.build

      # BUILD ORDER ITEMS
      cart.items.each do |product|
        order.items.build(product_id: product.id, quantity: product.quantity, price: product.price, total: product.total)
      end

      # BUILD SHIPPING ADDRESS
      address = (user.addresses.shipping[0] or user.addresses[0])

      order.build_shipping(address.attributes.except('id', 'user_id', 'active', 'created_at', 'updated_at')) if(address.present?)
      order.save ? order : false
    else
      false
    end
  end

  def waiting?
    payment_status && payment_status.eql?('waiting')
  end

  def update_shipping(params)
    return false unless(waiting? or params[:shipping].present?)
    params   = params[:shipping].merge!({kind: 'shipping'})
    shipping = build_shipping(params)
    if shipping.valid?
      customer.addresses.create(params) if customer.addresses.shipping.empty?
      (save; self)
    else
      false
    end
  end

  def update_consultant(id)
    consultant = Consultant.find_by_id(id)
    consultant ? update_attributes(consultant: consultant) : false
  end

  def ready_to_checkout?
    (customer.present? && shipping.present? && consultant.present?)
  end

  def checkout(params)
    return false unless ready_to_checkout?
    update_attributes(params)
  end

  def status_br
    STATUS[payment_status].present? ? STATUS[payment_status] : STATUS["waiting"]
  end

  def gateway_payment_status
    status = Gateway.payment_status(self.payment_invoice_id)
    return false unless status.present?
    self.payment_status = status
    self.save
  end

  def invoice_api
    {id: payment_invoice_id, url: gateway_url}
  end

  def invalid_status?
    return ready_to_checkout? ? Order::STATUS[payment_status] : "Cancelado"
  end

  STATUS = {
    "waiting"   => "Aguardando",
    "pending"   => "Aguardando",
    "confirmed" => "Confirmado",
    "paid"      => "Pago",
    "approved"  => "Aprovado",
    "expired"   => "Expirado",
    "cart"      => "Cart",
    ""          => "Incompleto",
    nil         => "Incompleto"
  }

  PAYMENT_METHODS = { "Boleto" => "bank_slip", "Cartão de crédito" => "credit_card" }

  before_create do |o|
    o.number = CodeGenerator.generate.first(8).upcase
  end

  after_save do |o|
    o.update_columns(slug: o.number.parameterize, total: o.items.collect(&:total).sum)
  end

end
