class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:admin_action]

  private

  def check_admin
    return if current_user.admin?

      flash[:alert] = 'Você não tem permissão para acessar esta página.'
      redirect_to root_path
  end
end
