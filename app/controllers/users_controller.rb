class UsersController < ApplicationController
  before_action :verify_admin, only: %i[index admin_edit admin_update]
  before_action :find_user, only: %i[show edit update admin_edit admin_update]

  def show
    @user = User.find(params[:id])
    redirect_to root_path, alert: 'Only staff members can have profiles.' unless @user.staff?
    @periods = @user.periods.asc(:period)
    @onboarding = @user == Current.user ? @user.onboarding_steps : []
  end

  def index
    @users = User.all.includes(:badge).order(%i[super_admin desc], %i[bot desc]).page(params[:page])
  end

  def autocomplete
    @users = if params[:term]
               User.any_of({ name: /.*#{params[:term]}.*/i }, email: /.*#{params[:term]}.*/i).limit(5)
             else
               User.all
             end

    respond_to do |format|
      format.json { render json: @users.map { |u| { value: u.id.to_s, label: u.name, desc: u.email } }.to_json }
    end
  end

  def new
    authorize User
  end

  def populate
    authorize User, :create

    # parses users input and generates emails for users with only a name provided
    users = params[:users].split("\n").map { |u| u.split(', ') }
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

  def edit; end

  def update
    authorize Current.user
    if Current.user.update(params.require(:user).permit(:bio, :picture))
      redirect_to user_path(Current.user)
    else
      render action: 'edit'
    end
  end

  def admin_edit; end

  def admin_update
    if @user.update_attributes(params.require(:user).permit(:name, :badge, :picture, :bio, :super_admin))
      flash[:notice] = 'Successfully updated User.'
      redirect_to users_path
    else
      render action: 'edit'
    end
  end

  private

  def verify_admin
    authorize :admin_panel, :users
  end

  def find_user
    @user = User.find(params[:id] || params[:user_id])
  end
end
