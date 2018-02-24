class Users::PoliciesController < ApplicationController
  include UserScoped

  before_action :set_policy

  def create
    authorize @policy, :edit
    authorize @user, :edit

    PolicyHolder.create(policy: @policy, user: @user)
  end

  def destroy
    authorize @policy, :edit
    authorize @user, :edit

    PolicyHolder.where(policy: @policy, user: @user).destroy_all
  end

  private
  def set_policy
    @policy = Scram::Policy.find(params[:id])
  end
end
