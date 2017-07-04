class LinksController < ApplicationController

  before_action :get_linkable, only: [:index]

  def index
    actions_builder = ActionsBuilder.new(current_holder)
    @links = if @linkable
      actions_builder.require(:edit, @linkable).add_action("New Link", :get, new_admin_link_path("#{@linkable.class.to_s.downcase}_id" => @linkable.id))
      @linkable.links.by_priority
    else
      (Link.escalated.sort_by!(&:created_at).to_a + Link.desc(:created_at).to_a).uniq
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
