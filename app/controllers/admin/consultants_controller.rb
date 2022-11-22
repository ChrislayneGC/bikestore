# encoding: utf-8
class Admin::ConsultantsController < AdminController

  def index
    @consultants = Consultant.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def search
    @criteria  = params[:search][:criteria]
    criteria   = "%#{@criteria}%"
    @result    = Consultant.where('name LIKE ? OR email LIKE ?', criteria, criteria).order('name ASC')
    @count = @result.count
    @consultants   = Kaminari.paginate_array(@result).page(params[:p])
  end

  def show
    @consultant = Consultant.find(params[:id])
  end


  def new
    @consultant = Consultant.new
    @consultant.addresses.build
    @consultant.accounts.build
  end

  def create
    @consultant = Consultant.new(consultant_params)
    if @consultant.save
      flash[:notice] = "Cadastro do usuário #{@consultant.name} criado com sucesso!"
      redirect_to [:admin, :consultants]
    else
      flash[:danger] = "Não foi possível criar o cadastro do usuário #{@consultant.name}, verifique os campos e tente novamente"
      render 'new'
    end
  end

  def edit
    @consultant = Consultant.find(params[:id])
  end

  def update
    @consultant = Consultant.find(params[:id])
    if @consultant.update_attributes(consultant_params)
      flash[:notice] = "Cadastro do usuário #{@consultant.name} alterado com sucesso!"
      redirect_to [:admin, :consultants]
    else
      flash[:danger] = "Não foi possível atualizar o cadastro do usuário #{@consultant.name}, tente novamente"
      render 'edit'
    end
  end

  private

  def consultant_params
    params.require(:consultant).permit(:id, :name, :username, :email, :password, :phone, :identifier, :active, addresses_attributes:[:id, :user_id, :zipcode, :street, :district, :number, :kind, :state, :city], accounts_attributes:[:id, :name, :identifier, :agency, :bank, :account, :active])
  end

end
