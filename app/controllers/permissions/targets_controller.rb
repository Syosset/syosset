class Permissions::TargetsController < ApplicationController
  include PolicyScoped

  before_action :set_target, only: %i[show edit update]

  def index
    authorize @policy
    @targets = @policy.targets
  end

  def show
    authorize @target
  end

  def new
    @target = Scram::Target.new
    authorize @target
  end

  def create
    @target = Scram::Target.new(target_params)
    @target.policy = @policy
    @target.actions = params[:target][:actions].split(',')

    authorize @target

    if @target.save
      redirect_to policy_target_path(@policy, @target)
    else
      render action: :new
    end
  end

  def edit
    authorize @target
  end

  def update
    authorize @target
    @target.actions = params[:target][:actions].split(',')
    @target.conditions = {}
    if @target.update(target_params)
      redirect_to policy_target_path(@policy, @target)
    else
      render action: :edit
    end
  end

  def destroy
    authorize @target

    @target.destroy
    redirect_to policy_targets_path(@policy)
  end

  private

  def set_target
    @target = @policy.targets.find(params[:id])
  end

  def target_params
    params.require(:target).permit(:priority, :allow, actions: [], conditions: {})
  end
end
