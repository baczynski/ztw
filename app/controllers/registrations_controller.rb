class RegistrationsController < Devise::RegistrationsController

private

  def sign_up_params
    params.require(:player).permit(:email, :password, :password_confirmation,
                                    :first_name, :surname, :date_of_birth,
                                    address_attributes: [:city, :zip_code, :street_address])
  end
end