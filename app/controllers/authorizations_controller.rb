class AuthorizationsController < ApplicationController
  before_action :get_user
  before_action :get_authorization, only: [:edit, :update, :destroy]

  def new
    @authorization = @user.authorizations.build
  end

  def create
    @authorization = @user.authorizations.build(authorization_params)

    if @authorization.save
      redirect_to user_authorizations_path(@user), notice: 'Authorization created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @authorization.update(authorization_params)
      redirect_to user_authorizations_path(@user), notice: 'Authorization updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @authorization.destroy
    redirect_to user_authorizations_path(@user), notice: 'Authorization deleted.'
  end

  private

  def get_user
    @user = User.find(params[:user_id])
  end

  def get_authorization
    @authorization = Authorization.find(params[:id])
  end

  def authorization_params
    params.require(:authorization).permit(:provider, :uid)
  end

  # send users to users#edit, as there is no index
  def user_authorizations_path(user)
    edit_user_path(user)
  end
end
