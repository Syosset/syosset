class Users::RegistrationsController < Devise::RegistrationsController

  def update
    authorize current_user
    if current_user.update(params.require(:user).permit(:bio, :picture))
      redirect_to user_path(current_user)
    else
      render action: 'edit'
    end
  end

end