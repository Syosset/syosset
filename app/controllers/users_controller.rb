class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def index
    authorize User
    @users = User.all.includes(:badge).order(%i[bot desc], %i[super_admin desc], %i[badge desc]).page(params[:page])
  end

  def show
    authorize @user
    redirect_to root_path, alert: 'Only staff members can have profiles.' unless @user.staff?
    @periods = @user.periods.asc(:period)
    @onboarding = @user == Current.user ? @user.onboarding_steps : []

    actions_builder = ActionsBuilder.new(current_holder, user: @user)
    actions_builder.require(:edit).render('Edit Profile', :get, edit_user_path(@user))
    actions_builder.require(:edit).render('Manage Schedule', :get, user_periods_path(@user))
    @actions = actions_builder.actions
  end

  def new
    authorize User
  end

  def create
    authorize User, :create

    # parses users input and generates emails for users with only a name provided
    users = params[:users]
            .split("\n")
            .map { |u| u.split(', ') }
            .map { |u| u.size == 1 ? [u[0], (u[0][0] + u[0].split(' ')[1] + '@syosset.k12.ny.us').downcase] : u }
            .map { |u| User.find_or_create_by(email: u[1]) { |u1| u1.name = u[0] } }

    if params[:collaborator_group].empty?
      redirect_to users_path, notice: "#{users.size} users created."
    else
      group = CollaboratorGroup.find(params[:collaborator_group])
      users.each { |u| group.add u }
      redirect_to users_path, notice: "#{users.size} users created and added to #{group.collaboratable.name}."
    end
  end

  def edit
    authorize @user
  end

  def update
    authorize @user

    if @user.update_attributes(user_params)
      flash[:notice] = 'Successfully updated User.'
      redirect_to user_path(@user)
    else
      render action: 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    if @user.super_admin
      params.require(:user).permit(:bio, :picture, :name, :badge, :super_admin)
    else
      params.require(:user).permit(:bio, :picture)
    end
  end
end
