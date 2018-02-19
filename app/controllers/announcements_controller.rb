class AnnouncementsController < ApplicationController

  before_action :get_announcement, only: [:show, :update, :destroy, :edit]
  before_action :get_announceable, only: [:index, :new, :create, :edit, :update]

  def index
    actions_builder = ActionsBuilder.new(current_holder)
    @announcements =
      if @announceable
        actions_builder.require(:edit, @announceable)
          .add_action("New Announcement", :get,
            new_announcement_path("#{@announceable.class.to_s.downcase}_id" => @announceable.id))

        @announceable.announcements.by_priority
      else
        Announcement.desc(:created_at)
      end

    @actions = actions_builder.actions
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder)
    @announceable = @announcement.announceable

    actions_builder.require(:edit, @announceable)
      .add_action("Edit Announcement", :get,
        edit_announcement_path(@announcement, "#{@announceable.class.to_s.downcase}_id" => @announceable.id))

    actions_builder.require(:edit, @announceable)
      .add_action("Destroy Announcement", :delete, announcement_path(@announcement), data: { confirm: 'Are you sure?' })

    actions_builder.require(:edit, @announceable)
      .add_action("Request Frontpage Visibility", :get, new_escalation_request_path(announcement_id: @announcement))

    actions_builder.require(:edit, @announceable)
      .add_action("View Audit Log", :get, history_trackers_path(announcement_id: @announcement.id))

    @actions = actions_builder.actions
  end

  def create
    authorize @announceable, :edit

    @announcement = Announcement.new(announcement_params)
    @announcement.poster = Current.user
    @announcement.announceable = @announceable

    @announcement.save

    if @announcement.errors.empty?
      flash[:notice] = 'Announcement successfully created.'
      redirect_to @announcement
    else
      flash.now[:alert] = @announcement.errors.full_messages.first
      render action: 'new'
    end
  end

  def new
    authorize @announceable, :edit
    @announcement = Announcement.new(announceable: @announceable)
  end

  def edit
    authorize @announcement, :edit
  end

  def update
    authorize @announcement, :edit
    @announcement.update!(announcement_params)
    redirect_to @announcement, flash: {:success => "Announcement has been updated"}
  end

  def destroy
    authorize @announcement, :edit
    @announcement.destroy
    redirect_to @announcement.announceable, flash: {:alert => "Announcement destroyed"}
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

  def announcement_params
    params.require(:announcement).permit(:name, :markdown).merge(modifier: Current.user)
  end
end
