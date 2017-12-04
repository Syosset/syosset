class ActivitiesController < ApplicationController
  before_action :get_activity, only: [:show, :subscribe, :unsubscribe]

  def index
    actions_builder = ActionsBuilder.new(current_holder)
    actions_builder.require(:create, @activity).add_action("New Activity", :get, new_admin_activity_path)
    @actions = actions_builder.actions

    @activities = Activity.full_text_search(params[:search], allow_empty_search: true).asc(:name).page params[:page]
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder)
    actions_builder.require(:edit, @activity).add_action("Edit Activity", :get, edit_admin_activity_path(@activity))
    actions_builder.require(:edit, @activity).add_action("Manage Collaborators", :get, edit_admin_collaborator_group_path(@activity.collaborator_group))
    actions_builder.require(:edit, @activity).add_action("Make Announcement", :get, new_announcement_path(activity_id: @activity.id))
    actions_builder.require(:edit, @activity).add_action("Make Link", :get, new_link_path(activity_id: @activity.id))
    actions_builder.require(:destroy, @activity).add_action("Destroy Activity", :delete, admin_activity_path(@activity), data: { confirm: 'Are you sure?' })
    @actions = actions_builder.actions
  end

  def subscribe
    @activity.subscribe_user(current_user)
    redirect_to activity_path(@activity), :notice => 'Successfully subscribed to activity.'
  end

  def unsubscribe
    @activity.unsubscribe_user(current_user)
    redirect_to activity_path(@activity), :notice => 'Successfully un-subscribed from activity.'
  end

  private
  def get_activity
    @activity = Activity.find(params[:id])
  end


end
