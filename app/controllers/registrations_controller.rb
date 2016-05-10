class RegistrationsController < Devise::RegistrationsController
  before_filter :build_address

private

  def build_address
    if current_player
      current_player.build_address unless current_player.address
    end
  end

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

  def sign_up_params
    params.require(:player).permit(:email, :password, :password_confirmation,
                                    :first_name, :surname, :date_of_birth,
                                    address_attributes: [:city, :zip_code, :street_address])
  end

  def account_update_params
    params.require(:player).permit(:email, :first_name, :surname, :date_of_birth,
                                    address_attributes: [:city, :zip_code, :street_address])
  end
end