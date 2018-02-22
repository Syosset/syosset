module Scram
  class PoliciesController < ApplicationController
    before_action :set_policy

    def index
      authorize Policy

    end

    def show
      authorize @policy
    end

    def new
      @policy = Policy.new
      authorize @policy
    end

    def create
      @policy = Policy.new(policy_params)
      authorize @policy

      if @policy.save
        redirect_to scram_policy_path(@policy)
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
        redirect_to scram_policy_path(@policy)
      else
        render action: :edit
      end
    end

    def destroy
      authorize @policy

      @policy.destroy
      redirect_to scram_policies_path
    end

    private

    def set_policy
      @policy = Policy.find(params[:id])
    end

    def policy_params
      params.require(:policy).permit(:name, :context, :priority, :targets)
    end
  end
end