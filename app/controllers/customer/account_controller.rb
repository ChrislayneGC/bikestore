#encoding: utf-8
class Customer::AccountController < CustomerController

  def edit
    @user = current_customer
  end

  def update
    @user = current_customer
    if @user.update_attributes(customer_params)
      redirect_to [:customer_show], notice: "Dados atualizados com sucesso!"
    else
      render 'edit'
    end
  end

  def edit_address
    @addresses = current_customer.addresses
  end

  def update_address
    if address_params['id'].present?
      @address = Address.find(address_params[:id])
      if @address.update_attributes(address_params)
        flash[:notice] = "Endereço atualizado com sucesso!"
      else
        flash[:notice] = "Ocorreu um problema na atualização do endereço, verifique os dados informados e tente novamente!"
      end
    else
      @address = Address.new(address_params)
      if @address.save
        flash[:notice] = "Endereço criado com sucesso!"
      else
        flash[:notice] = "Ocorreu um problema ao criar o endereço, verifique os dados e tente novamente!"
      end
    end
    redirect_to edit_address_customer_account_index_path()
  end

  def new_address
    current_customer.addresses.build
    @addresses = current_customer.addresses
    render 'edit_address'
  end

  private

  def address_params
    params.require(:address).permit(:id, :district, :user_id, :zipcode, :street, :district, :number, :kind, :state, :city)
  end

  def customer_params
    params.require(:customer).permit(:name, :email, :phone, :username, :mobile, :identifier, :image, addresses_attributes:[:id, :district, :user_id, :zipcode, :street, :district, :number, :kind, :state, :city])
  end

end
