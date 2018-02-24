class Permissions::PoliciesController < ApplicationController
  before_action :set_policy, only: %i[show edit update destroy]

  def index
    authorize Scram::Policy
    @policies = Scram::Policy.all
  end

  def show
    authorize @policy
    @targets = @policy.targets
  end

  def new
    @policy = Scram::Policy.new
    authorize @policy
  end

  def create
    @policy = Scram::Policy.new(policy_params)
    authorize @policy

    if @policy.save
      redirect_to policy_path(@policy)
    else
      render action: :new
    end
  end

  def edit
    authorize @policy
  end

  def update
    authorize @policy

    if @policy.update(policy_params)
      redirect_to policy_path(@policy)
    else
      render action: :edit
    end
  end

  def destroy
    authorize @policy

    @policy.destroy
    redirect_to policies_path
  end

  private

  def set_policy
    @policy = Scram::Policy.find(params[:id])
  end

  def policy_params
    params.require(:policy).permit(:name, :context, :priority)
  end
end
