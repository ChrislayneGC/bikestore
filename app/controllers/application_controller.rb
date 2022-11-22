class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :devise_permitted_params, if: :devise_controller?


  protected

  def devise_permitted_params
    permitted = [:login, :type, :name, :email, :phone, :mobile, :reset_password_token, :identifier, :password, :password_confirmation, addresses_attributes: [:id, :user_id, :street, :number, :zipcode, :kind, :district, :city, :state, :latitude, :longitude, :complement]]
    devise_parameter_sanitizer.permit :sign_up, keys: permitted
    devise_parameter_sanitizer.permit :account_update, keys: permitted
  end

  def after_sign_in_path_for(resource)
    if resource.class == Customer
      root_path
    elsif resource.class == Consultant
      root_path
    elsif resource.class == Admin
      root_path
    else
      root_path
    end
  end
end
