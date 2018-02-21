class AnnouncementsController < ApplicationController
  before_action :get_announcement, only: %i[show update destroy edit]
  before_action :get_announceable, only: %i[index new create edit update]

  def index
    actions_builder = ActionsBuilder.new(holder: current_holder, resource: @announceable)
    @announcements =
      if @announceable
        actions_builder.require(:edit)
                       .render('New Announcement', :get,
                                   new_announcement_path("#{@announceable.class.to_s.downcase}_id" => @announceable.id))

        @announceable.announcements.by_priority
      else
        Announcement.desc(:created_at)
      end

    @actions = actions_builder.actions
  end

  def show

    actions_builder = ActionsBuilder.new(holder: current_holder, resource: @announcement)

    actions_builder.require(:edit) do
      announceable = resource.announceable

      render('Edit Announcement', :get,
                 edit_announcement_path(resource, "#{announceable.class.to_s.downcase}_id" => announceable))
      render('Destroy Announcement', :delete, announcement_path(resource), data: { confirm: 'Are you sure?' })
      render('Request Frontpage Visibility', :get, new_escalation_request_path(announcement_id: resource))
      render('View Audit Log', :get, history_trackers_path(announcement_id: resource))
    end

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
    redirect_to @announcement, flash: { success: 'Announcement has been updated' }
  end

  def destroy
    authorize @announcement, :edit
    @announcement.destroy
    redirect_to @announcement.announceable, flash: { alert: 'Announcement destroyed' }
  end

  private

  def get_announcement
    @announcement = Announcement.find(params[:id])
  end

  def get_announceable
    params.each do |name, value|
      return @announceable = Regexp.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end

  def announcement_params
    params.require(:announcement).permit(:name, :markdown).merge(modifier: Current.user)
  end
end
