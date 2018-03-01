class LinksController < ApplicationController
  before_action :get_linkable, only: %i[index new create edit update]
  before_action :get_link, only: %i[update destroy edit]

  def index
    actions_builder = ActionsBuilder.new(current_holder, resource: @linkable)
    @links =
      if @linkable
        actions_builder.require(:edit)
                       .render('New Link', :get, new_link_path("#{@linkable.class.to_s.downcase}_id" => @linkable))
        @linkable.links.full_text_search(params[:search], allow_empty_search: true).by_priority.desc(:created_at)
      else
        Link.full_text_search(params[:search], allow_empty_search: true).by_priority.desc(:created_at)
      end

    @links = @links.page params[:page]

    @actions = actions_builder.actions
  end

  def create
    authorize @linkable, :edit

    @link = Link.new(link_params)
    @link.poster = Current.user
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
    redirect_to @link.linkable, flash: { success: 'Link has been updated' }
  end

  def destroy
    authorize @link, :edit
    @link.destroy
    redirect_to @link.linkable, flash: { alert: 'Link destroyed' }
  end

  private

  def get_linkable
    params.each do |name, value|
      return @linkable =  Regexp.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    if params[:action] == 'create' || params[:action] == 'new'
      redirect_to root_path, flash: { alert: 'Links can only be created from an linkable.' }
    end
    nil
  end

  def get_link
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:name, :icon, :target)
  end
end
