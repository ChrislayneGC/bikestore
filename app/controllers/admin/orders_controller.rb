# encoding: utf-8
class Admin::OrdersController < AdminController

  def index
    @orders = Order.all.order(created_at: :desc).page(params[:page]).per(14)
  end

  def search
    @init  = params[:search][:init]
    @end  = params[:search][:end]
    @result = Order.where('created_at >= ? AND created_at <= ?', Date.parse(@init), Date.parse(@end) ).order(created_at: :asc)
    @count = @result.count
    @orders   = Kaminari.paginate_array(@result).page(params[:page])
  end

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.friendly.find(params[:id])
    if @order.update_attributes(order_params)
      flash[:notice] = "Dados do pedido alterado com sucesso!"
      redirect_to [:admin, :orders]
    else
      flash[:danger] = "Não foi possível atualizar o pedido, tente novamente"
      render 'edit'
    end
  end

  def show
    @order = Order.friendly.find(params[:id])
  end


  private

  def order_params
    params.require(:order).permit!
  end

end
