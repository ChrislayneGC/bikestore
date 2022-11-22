# encoding: utf-8
class Admin::CustomersController < AdminController

  def index
    @customers = Customer.all.order(created_at: :desc).page(params[:page]).per(8)
  end

  def search
    @criteria  = params[:search][:criteria]
    criteria   = "%#{@criteria}%"
    @result    = Customer.where('name LIKE ? OR email LIKE ?', criteria, criteria).order('name ASC')
    @count = @result.count
    @customers   = Kaminari.paginate_array(@result).page(params[:page])
  end

  def new
    @customer = Customer.new
    @type = @customer.class
    @customer.addresses.build
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      flash[:notice] = "Cadastro do usuário #{@customer.name} criado com sucesso!"
      redirect_to [:admin, :customers]
    else
      flash[:danger] = "Não foi possível criar o cadastro do usuário #{@customer.name}, verifique os campos e tente novamente"
      render 'new'
    end
  end

  def edit
    @customer = Customer.find(params[:id])
    @type = @customer.class
  end

  def update
    @customer = Customer.friendly.find(params[:id])
    if @customer.update_attributes(customer_params)
      flash[:notice] = "Cadastro do usuário #{@customer.name} alterado com sucesso!"
      redirect_to [:admin, :customers]
    else
      flash[:danger] = "Não foi possível atualizar o cadastro do usuário #{@customer.name}, tente novamente"
      render 'edit'
    end
  end

  def show
    @customer = Customer.friendly.find(params[:id])
  end


  private

  def customer_params
    params.require(:customer).permit(:id, :name, :username, :email, :password, :phone, :identifier, :active, addresses_attributes:[:id, :user_id, :zipcode, :street, :district, :number, :kind, :state, :city])
  end

end
