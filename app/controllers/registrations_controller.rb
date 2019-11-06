class RegistrationsController < ApplicationController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]
    private

  def sign_up_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation)
  end

  def account_update_params
    params.require(:user).permit(:nickname, :email, :password, :password_confirmation, :current_password)
  end
end
