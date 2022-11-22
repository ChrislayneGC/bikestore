class Customer::CartsController < CustomerController
  before_action :cart, only: [:add_item, :remove_item, :update_item, :show]
  skip_before_action :authenticate_customer, only: [:add_item]

  def show

  end

  def add_item
    return redirect_to [:customer_session] unless current_customer
    @item = Item.friendly.find(params[:item_id])
    hash_item = {items: [id: @item.id, quantity: 1]}
    @cart = @cart.push(hash_item)
    @items_count = @cart.items.count
    # render partial: 'add_item'
  end

  def remove_item
    hash_item = {items: [id: params[:id]]}
    @cart = @cart.remove(hash_item)
  end

  def update_item
    quantity =  params[:cart][:cart_item][:quantity]
    item = params[:cart][:cart_item][:id]
    availability_response = @cart.item_available?(item, quantity)
    if availability_response[:available]
      item = {'id' => params[:cart][:cart_item][:id], 'quantity' => params[:cart][:cart_item][:quantity]}
      @target = {"id" => params[:cart][:cart_item][:id], "info" => "Quantidade atualizada!"}
      hash_item = {items: [id: params[:cart][:cart_item][:id], quantity: params[:cart][:cart_item][:quantity]]}
      @cart = @cart.update(hash_item)
    else
      item = {'id' => params[:cart][:cart_item][:id], 'quantity' => availability_response[:max_amount]}
      @target = {"id" => params[:cart][:cart_item][:id], "info" => "A quantidade máx disponível é #{availability_response[:max_amount]}!"}
      hash_item = {items: [id: params[:cart][:cart_item][:id], quantity: availability_response[:max_amount]]}
      @cart = @cart.update(hash_item)
    end
  end

  def shipping
    # @cart = Cart.find(params[:id])
    @order = order
    unless @order
      session.delete(:cart)
      session.delete(:order)
      return redirect_to :root, flash: {notice: "Esse pedido já foi pago ou está aguardando pagamento"}
    end
    unless !@order.payment_invoice_id
      session.delete(:cart)
      session.delete(:order)
      return redirect_to :root, flash: {notice: "Esse pedido já foi pago ou está aguardando pagamento"}
    end
    @shipping = @order.build_shipping(current_customer.addresses.first.to_hash)
    @order.save
    @freight = @order.generate_freight
  end

  def consultant
    @order = order
    return redirect_to :root, flash: {notice: "Esse pedido já foi pago ou está aguardando pagamento"} unless @order.payment_status.eql?("waiting") || @order.payment_status.eql?("cart")
    if @order.update_attributes(order_params)
      @consultants = current_user.consultants_near.uniq
      @favorites = current_customer.favorite_consultants - @consultants
      @order
    else
      flash[:notice] = "Ocorreu um problema ao salvar os dados de entrega, preencha os campos obrigatórios e tente novamente"
      redirect_to [:root]
    end
  end

  def order
    if current_customer && session[:cart].present? && !session[:order].present?
      @order = Order.create_from_cart(cart)
      session[:order] = @order.id
      session.delete(:cart)
      @cart = nil
    elsif session[:order].present?
      @order = current_customer.orders.find(session[:order])
    else
      return false
    end
    @order
  end

  def freight
    @order = order
    if @order.shipping.update_attributes(shipping_attributes[:shipping_attributes])
      @shipping = @order.shipping
      @freight = @order.generate_freight
      render 'shipping'
    else
      # @freight = @order.generate_freight
      flash[:notice] = "Não foi possível calcular o frete, verifique os campos e tente novamente."
    end
  end

  def cart
    if current_customer && session[:cart]
      @cart = current_customer.carts.find(session[:cart])
    else
      @cart = current_customer.carts.build
      @cart.save
      session[:cart] = @cart.id
    end
  end

	def payment
        @order = order
        unless params[:order][:shipping_attributes][:kind].eql?("Retirar")
            if @order.shipping.state.downcase.eql?("pr")
                #raise params[:order].inspect 
                if params[:order][:shipping_attributes][:kind].eql?("SEDEX")
                    @order.generate_sedex
                else
                    @order.generate_pac
                end
            else
                return redirect_to :root, flash: {notice: "Só entregamos no Paraná!"}
            end
        end
  end

  private

  def order_params
    params.require(:order).permit(:id, shipping_attributes: [:id, :order_id, :zipcode, :street, :district, :number, :kind, :state, :city])
  end

  def shipping_attributes
    params.require(:order).permit(shipping_attributes: [:id, :order_id, :zipcode, :street, :district, :number, :kind, :state, :city])
  end

  def cart_params
    params.require(:cart).permit(:id, items_attributes: [:id, :quantity])
  end

end
