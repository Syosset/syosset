class AnnouncementsController < ApplicationController

  before_action :get_announcement, except: [:index]
  before_action :get_announceable, only: [:index]

  def index
    actions_builder = ActionsBuilder.new(current_holder)
    @announcements = if @announceable
      actions_builder.require(:edit, @announceable).add_action("New Announcement", :get, new_admin_announcement_path("#{@announceable.class.to_s.downcase}_id" => @announceable.id))
      @announceable.announcements.by_priority
    else
      Announcement.desc(:created_at)
    end

    @actions = actions_builder.actions
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder)
    @announceable = @announcement.announceable
    actions_builder.require(:edit, @announceable).add_action("Edit Announcement", :get, edit_admin_announcement_path(@announcement, "#{@announceable.class.to_s.downcase}_id" => @announceable.id))
    actions_builder.require(:edit, @announceable).add_action("Destroy Announcement", :delete, admin_announcement_path(@announcement), data: { confirm: 'Are you sure?' })
    actions_builder.require(:edit, @announceable).add_action("Request Frontpage Visibility", :get, new_admin_escalation_request_path(announcement_id: @announcement))
    @actions = actions_builder.actions
  end

  private
  def get_announcement
    @announcement = Announcement.find(params[:id])
  end

  def get_announceable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return @announceable =  $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
