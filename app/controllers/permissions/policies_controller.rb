class Permissions::PoliciesController < ApplicationController
  before_action :set_policy, only: %i[show edit update destroy]

  def index
    authorize Scram::Policy
    @policies = Scram::Policy.all

    @actions = ActionsBuilder.new(current_holder).require(:edit, Scram::Policy) do
      render('Create Policy', :get, new_policy_path)
    end.actions
  end

  def show
    authorize @policy
    @targets = @policy.targets

    @actions = ActionsBuilder.new(current_holder, policy: @policy).require(:edit) do
      render('Edit Policy', :get, edit_policy_path(policy))
      render('Create Target', :get, new_policy_target_path(policy_id: policy))
      render('Destroy Policy', :delete, policy_path(policy), data: { confirm: 'Are you sure?' })
    end.actions
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
    # The system in place allows any type of Holder, but our UI will be focused on user management
    @users = @policy.holders.select { |h| h.is_a? User }
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
    redirect_to policies_path, flash: { alert: 'Policy destroyed' }
  end

  private

  def set_policy
    @policy = Scram::Policy.find(params[:id])
  end

  def policy_params
    params.require(:policy).permit(:name, :context, :priority)
  end
end
