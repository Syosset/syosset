class Users::PoliciesController < ApplicationController
  include UserScoped

  before_action :set_policy

  def create
    authorize @policy, :edit
    authorize @user, :edit

    @user.policies.add(@policy)
    @user.save
  end

  def destroy
    authorize @policy, :edit
    authorize @user, :edit

    @user.policies.delete(@policy)
    @user.save
  end

  private
  def set_policy
    @policy = Scram::Policy.find(params[:id])
  end
end
