#encoding: utf-8
class Customer::CredentialsController < CustomerController
  skip_before_action :authenticate_customer, only: [:update_password]

  def update_password
    user = User.where(reset_password_token: params[:user][:reset_password_token]).first
    response = user.reset_password(params[:user][:password], params[:user][:password_confirmation])
    if response
      flash[:notice] = "Senha alterada com sucesso"
    else
      flash[:notice] = "Não foi possível alterar a senha, verifique se a confirmação de senha e a senha são iguais e se a senha tem mais de 6 caracteres"
    end
    redirect_to [:root]
  end

  
  def customer_params
    params.require(:customer).permit(:name, :email, :phone, :username, :mobile, :identifier, :image, addresses_attributes:[:id, :district, :user_id, :zipcode, :street, :district, :number, :kind, :state, :city])
  end

end
