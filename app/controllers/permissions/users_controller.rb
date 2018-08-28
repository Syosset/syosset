class Permissions::UsersController < ApplicationController
  include PolicyScoped

  before_action :set_user

  def create
    authorize @policy, :edit
    authorize @user, :edit

    Scram::PolicyHolder.create(policy: @policy, holder: @user)
    redirect_to edit_policy_path(@policy), flash: { success: 'Holder was added successfully' }
  end

  def destroy
    authorize @policy, :edit
    authorize @user, :edit

    Scram::PolicyHolder.where(policy: @policy, holder: @user).destroy_all
    redirect_to edit_policy_path(@policy), flash: { success: 'Holder was removed successfully' }
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
