class CustomerController < ApplicationController
  before_filter :authenticate_customer!, except: [:update_password]

  def index
    redirect_to [:root]
  end

  def show
    @categories = Category.active
    @user = current_customer
    @orders = current_customer.orders.page(params[:page]).per(5)
    @orders_waiting = current_customer.orders
    @orders_waiting = Kaminari.paginate_array(@orders_waiting).page(params[:page]).per(5)
    @pending_orders = current_customer.orders
    @pending_orders = Kaminari.paginate_array(@pending_orders).page(params[:page]).per(5)
  end

  def edit
    @user = current_customer
    @type = "Customer"
  end

  def update
    @user = current_customer
    if @user.update_attributes(customer_params)
      flash[:notice] = "Cadastro atualizado!"
    else
      flash[:alert] = "Ocorreu um problema ao atualizar o cadastro: #{@user.errors.messages}"
    end
    bypass_sign_in(@user)
    redirect_to [current_customer]
  end

  def consultant
    @consultant = Consultant.friendly.find(params[:consultant_id])
    @favorite = UserFavorite.where(consultant: @consultant, customer: current_customer).first
    @favorite = current_customer.favorites.build unless @favorite
  end

  def order
    @order = current_customer.orders.find(params[:id])
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :identifier, :phone, :password, :image, suppliers_ids:[], addresses_attributes: [:id, :user_id, :street, :number, :zipcode, :kind, :district, :city_id, :state_id, :latitude, :longitude])
  end

end
