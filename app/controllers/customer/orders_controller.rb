class Customer::OrdersController < CustomerController

  def credit_card
    @order = current_customer.orders.find(params[:order][:id])
    @order.pay_with_credit_card(params[:cc])
    partial = params[:order][:partial]
    return redirect_to :root, flash: {notice: "Esse pedido já foi pago ou está aguardando pagamento"} if @order.payment_invoice_id
    response = Gateway.checkout_credit_card(current_customer, token, @order, @order.shipping)
    if response.errors.present?
      redirect_to :back, flash: {notice: response.errors}
    else
      session.delete(:order)
      render 'customer/orders/credit_card'
    end
  end

  def billet
    response = Checkout.create(params[:order][:id])
    #@order = current_customer.orders.find(params[:order][:id])
   # return redirect_to :root, flash: {notice: "Esse pedido já foi pago ou está aguardando pagamento"} if @order.payment_invoice_id
    #if @order.save
      #response = MundiPagg.charge_billet(current_customer, @order, @order.shipping)
      #unless response[:status] == true
        #return  redirect_to [:back], notice: "Houve um problema ao salvar o seu pedido. Antes de continuar verifique seu telefone e endereço..."
      #end
      session.delete(:order)
      @url = response.url
      redirect_to @url
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  def index
    @orders = current_customer.orders.order(created_at: 'desc').page(params[:page]).per(8)
  end

  def search
    if search_params[:init].present? && search_params[:end].present? && (search_params[:init].to_date < search_params[:end].to_date)
      @orders = current_customer.orders.where('created_at > ? AND created_at < ?', search_params[:init].to_date, search_params[:end].to_date).page(params[:page]).per(8)
      session[:search_init] = search_params[:init]
      session[:search_end] = search_params[:end]
    else
      @orders = current_customer.orders.where('created_at > ? AND created_at < ?', Date.today,  Date.today.end_of_month).page(params[:page]).per(8)
      session[:search_init] = Date.today.to_s_br
      session[:search_end] = Date.today.end_of_month.to_s_br
    end
  end

  def order_delivered
    @order = current_customer.orders.friendly.find(params[:id])
    return redirect_to [:customer_show] unless @order
    response = current_customer.order_delivered(@order.number)
    if response
      flash[:notice] = "O pedido #{@order.number} foi salvo como entregue!"
      redirect_to [:customer_show]
    else
      flash[:notice] = "Não foi possível atualizar o pedido #{@order.number}"
      redirect_to [:customer_show]
    end
  end

  private

  def search_params
    params.require(:search).permit(:init, :end)
  end

  def finish_order_params
    params.require(:order).permit(:delivered_in)
  end

end
