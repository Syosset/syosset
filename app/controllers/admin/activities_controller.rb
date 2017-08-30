module Admin
  class ActivitiesController < BaseController
    before_action :get_activity, only: [:edit, :update, :destroy]

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
      @activity.update!(activity_params)
      redirect_to activity_path(@activity), flash: {:success => "Activity has been updated"}
    end

    def destroy
      authorize @activity
      @activity.destroy
      redirect_to activities_path, flash: {:alert => "Activity destroyed"}
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
