class Users::AdminController < ApplicationController
  before_action :verify_admin
  before_action :set_user, only: %i[edit update]

  def index
    @users = User.all.includes(:badge).order(%i[super_admin desc], %i[bot desc]).page(params[:page])
  end

  def edit; end

  def update
    if @user.update_attributes(params.require(:user).permit(:name, :badge, :picture, :bio, :super_admin))
      flash[:notice] = 'Successfully updated User.'
      redirect_to user_admin_index_path
    else
      render action: 'edit'
    end
  end

  private
  def verify_admin
    authorize :admin_panel, :users
  end

  def set_user
    @user = User.find(params[:id])
  end
end
