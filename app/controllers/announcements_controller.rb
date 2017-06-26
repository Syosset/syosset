class AnnouncementsController < ApplicationController

  before_action :get_announcement, except: [:index]

  def index
    @announcements = Announcement.all
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder)
    @announceable = @announcement.announceable
    actions_builder.require(:edit, @announcement.announceable).add_action("Edit Announcement", :get, edit_admin_announcement_path(@announcement, "#{@announcement.announceable.class.to_s.downcase}_id" => @announcement.announceable.id))
    actions_builder.require(:edit, @announcement.announceable).add_action("Destroy Announcement", :delete, admin_announcement_path(@announcement), data: { confirm: 'Are you sure?' })
    actions_builder.require(:edit, @announcement.announceable).add_action("Request Frontpage Visibility", :delete, new_admin_escalation_request_path(announcement_id: @announcement))
    @actions = actions_builder.actions
  end

  private
  def get_announcement
    @announcement = Announcement.find(params[:id])
  end
end
