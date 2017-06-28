module Admin
  class AnnouncementsController < BaseController
    before_action :get_announceable, only: [:new, :create, :edit, :update]
    before_action :get_announcement, only: [:update, :destroy, :edit]
    
    def create
      authorize @announceable, :edit

      @announcement = Announcement.new(announcement_params)
      @announcement.poster = current_user
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
    def get_announceable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return @announceable =  $1.classify.constantize.find(value)
        end
      end
      nil
      redirect_to root_path, flash: {:alert => "Announcements can only be created from an announceable."}
    end

    def get_announcement
      @announcement = Announcement.find(params[:id])
    end

    def announcement_params
      params.require(:announcement).permit!
    end

  end
end
