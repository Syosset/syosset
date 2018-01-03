class UsersController < ApplicationController

  before_action :verify_admin, only: [:index, :edit, :update]
  before_action :find_user, only: [:show, :edit, :update]

  def show
    @user = User.find(params[:id])
    redirect_to root_path, alert: "Only staff members can have profiles." unless @user.staff?
    @periods = @user.periods.asc(:period)
    @onboarding = @user == current_user ? @user.onboarding_steps : []
  end

  def index
    @users = User.all.order([:super_admin, :desc], [:bot, :desc]).page(params[:page])
  end

  def new
    authorize User
  end

  def populate
    authorize User, :create

    # parses users input and generates emails for users with only a name provided
    users = params[:users].split("\n").map {|u| u.split(", ")}
                                      .map {|u| u.size == 1 ? [u[0], (u[0][0] + u[0].split(" ")[1] + '@syosset.k12.ny.us').downcase] : u}
                                      .map {|u| User.find_or_create_by(email: u[1]) {|user| user.name = u[0]; user.password = Devise.friendly_token[0,20]}}

    unless params[:collaborator_group].empty?
      group = CollaboratorGroup.find(params[:collaborator_group])
      users.each {|u| group.add u}
      redirect_to users_path, notice: "#{users.size} users created and added to #{group.collaboratable.name}."
    else
      redirect_to users_path, notice: "#{users.size} users created."
    end
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
    params.require(:user).permit(:name, :picture, :bio, :super_admin)
  end
end
