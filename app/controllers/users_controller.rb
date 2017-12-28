class UsersController < ApplicationController

  before_action :verify_admin, only: [:index, :edit, :update]
  before_action :find_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Only staff members can have profiles." unless @user.staff?
    @periods = @user.periods.asc(:period)
  end

  def index
    @users = User.all.page(params[:page])
  end

  def edit
  end

  def update
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(user_params)
      flash[:notice] = "Successfully updated User."
      redirect_to users_path
    else
      render :action => 'edit'
    end
  end

  private
  def verify_admin
    authorize :admin_panel, :users
  end

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit!
  end
end
