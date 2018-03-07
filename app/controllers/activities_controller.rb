class ActivitiesController < ApplicationController
  before_action :get_activity, only: %i[show edit update destroy subscribe unsubscribe]

  def index
    actions_builder = ActionsBuilder.new(current_holder, activity: @activity)
    actions_builder.require(:create).render('New Activity', :get, new_activity_path)
    @actions = actions_builder.actions

    @activities = Activity.full_text_search(params[:search], allow_empty_search: true).asc(:name).page params[:page]
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder, activity: @activity)

    actions_builder.require(:edit) do
      render('Edit Activity', :get, edit_activity_path(activity))
      render('Manage Collaborators', :get, edit_collaborator_group_path(activity.collaborator_group))
      render('View Audit Log', :get, history_trackers_path(activity_id: activity.id))
      render('Make Announcement', :get, new_announcement_path(activity_id: activity.id))
      render('Make Link', :get, new_link_path(activity_id: activity.id))
      render('Destroy Activity', :delete, activity_path(activity), data: { confirm: 'Are you sure?' })
    end

    @actions = actions_builder.actions
  end

  def subscribe
    @activity.subscribe_user(Current.user)
    redirect_to activity_path(@activity), notice: 'Successfully subscribed to activity.'
  end

  def unsubscribe
    @activity.unsubscribe_user(Current.user)
    redirect_to activity_path(@activity), notice: 'Successfully un-subscribed from activity.'
  end

  def create
    @activity = Activity.new(activity_params)
    authorize @activity

    @activity.save!
    redirect_to activity_path(@activity), flash: { success: 'Activity has been created' }
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
      redirect_to activity_path(@activity), flash: { success: 'Activity has been updated' }
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize @activity
    @activity.destroy
    redirect_to activities_path, flash: { alert: 'Activity destroyed' }
  end

  private

  def get_activity
    @activity = Activity.includes(:announcements, :links).find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:name, :type, :summary, :markdown).merge(modifier: Current.user)
  end
end
