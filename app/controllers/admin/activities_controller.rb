require 'action_view'

module Admin
  class ActivitiesController < BaseController
    include ActionView::Helpers::DateHelper
    
    before_action :get_activity, only: [:edit, :update, :destroy, :unlock]

    def create
      @activity = Activity.new(activity_params)
      authorize @activity

      @activity.save!
      redirect_to activity_path(@activity), flash: {:success => "Activity has been created"}
    end

    def new
      authorize Activity
      @activity = Activity.new
    end

    def edit
      authorize @activity
    end

    def update
      authorize @activity
      if @activity.update(activity_params)
        redirect_to activity_path(@activity), flash: {:success => "Activity has been updated"}
      else
        render action: "edit"
      end
    end

    def destroy
      authorize @activity
      @activity.destroy
      redirect_to activities_path, flash: {:alert => "Activity destroyed"}
    end

    def unlock
      granter = User.find(params[:granter_id])
      time = 30.minute # TODO: Make configurable

      if @activity.unlock(time, granter)
        redirect_to activity_path(@activity), flash: {:success => "Activity has been updated"}
      else
        redirect_to activity_path(@activity), flash: {:alert => "This page is already unlocked for another #{(distance_of_time_in_words(Time.now, @activity.unlock_grant.expire_at))}"}
      end
    end

    private
    def get_activity
      @activity = Activity.find(params[:id])
    end

    def activity_params
      params.require(:activity).permit!
    end
  end
end
