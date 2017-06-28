class LinksController < ApplicationController

  before_action :get_linkable, only: [:index]

  def index
    actions_builder = ActionsBuilder.new(current_holder)
    @links = if @linkable
      actions_builder.require(:edit, @linkable).add_action("New Link", :get, new_admin_link_path("#{@linkable.class.to_s.downcase}_id" => @linkable.id))
      @linkable.links.by_priority
    else
      Link.by_priority
    end

    @actions = actions_builder.actions
  end

  private
  def get_linkable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return @linkable =  $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
