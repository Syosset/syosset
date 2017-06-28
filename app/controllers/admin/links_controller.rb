module Admin
  class LinksController < BaseController
    before_action :get_linkable, only: [:new, :create, :edit, :update]
    before_action :get_link, only: [:update, :destroy, :edit]

    def create
      authorize @linkable, :edit

      @link = Link.new(link_params)
      @link.poster = current_user
      @link.linkable = @linkable

      @link.save

      if @link.errors.empty?
          flash[:notice] = 'Link successfully created.'
          redirect_to @linkable
      else
          flash.now[:alert] = @link.errors.full_messages.first
          render action: 'new'
      end
    end

    def new
      authorize @linkable, :edit
      @link = Link.new(linkable: @linkable)
    end

    def edit
      authorize @link, :edit
    end

    def update
      authorize @link, :edit
      @link.update!(announcement_params)
      redirect_to @link.linkable, flash: {:success => "Link has been updated"}
    end

    def destroy
      authorize @link, :edit
      @link.destroy
      redirect_to @link.linkable, flash: {:alert => "Link destroyed"}
    end

    private
    def get_linkable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return @linkable =  $1.classify.constantize.find(value)
        end
      end
      nil
      redirect_to root_path, flash: {:alert => "Links can only be created from an announceable."}
    end

    def get_link
      @link = Link.find(params[:id])
    end

    def link_params
      params.require(:link).permit!
    end

  end
end
