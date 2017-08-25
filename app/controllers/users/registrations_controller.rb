class Users::RegistrationsController < Devise::RegistrationsController

  def update
    authorize current_user
    current_user.update!(params.require(:user).permit(:bio))
    redirect_to user_path(current_user)
  end

end