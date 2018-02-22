# Builds a set of actions for a given ability
# Optionally, the user can be required to have certain permissions by chaining `require` repeatedly.
# The final set of built actions is available as `actions`
class ActionsBuilder
  attr_accessor :resource, :actions, :holder

  def initialize(holder: holder, resource: resource)
    @resource = resource
    @actions = []
    @holder = holder

    @required_permissions = []
  end

  # Chainable method to only add an action if a user has some permission
  # This method is quick fail; if any permission is missing, the chain dies
  def require(node, context = @resource, &block)
    @required_permissions << { node: node, context: context }

    @required_permissions.each do |permission|
      if holder.cannot? permission[:node], permission[:context]
        @required_permissions = [] # Reset method chain
        return NullActionsBuilder.new
      end
    end

    if block_given?
      self.instance_eval(&block)
      required_permissions = []
    end

    self
  end

  def render(text, method, path, options = {})
    action = [text, method, path, options]
    actions << action
    action
  end

  def method_missing(method, *args, &block)
    routes =  Rails.application.routes.url_helpers
    return routes.send(method, *args, &block) if routes.respond_to?(method)
    super
  end

  def respond_to_missing?(method, include_private = false)
    return true if Rails.application.routes.url_helpers.respond_to?(method)
    super
  end
end
