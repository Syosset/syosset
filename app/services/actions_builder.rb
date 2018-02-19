# Builds a set of actions for a given ability
# Optionally, the user can be required to have certain permissions by chaining `require` repeatedly.
# The final set of built actions is available as `actions`
class ActionsBuilder
  attr_accessor :actions
  attr_accessor :holder

  def initialize(holder)
    @holder = holder
    @actions = []

    # For method chaining
    @required_permissions = []
  end

  # Chainable method to only add an action if a user has some permission
  # Queues up all the needed permissions into required_permissions for checking when `add_action` is finally called
  def require(node, context)
    @required_permissions << { node: node, context: context }
    self
  end

  # Adds an action to the set of actions
  # Checks the required_permissions queue if any chains of `require` preceded a call to this method
  # Will return the action added, or nil otherwise
  def add_action(text, method, path, options = {})
    # User needs all of the permissions from previous method chain to actually have this action added
    @required_permissions.each do |permission|
      if holder.cannot? permission[:node], permission[:context]
        @required_permissions = [] # Reset method chain
        return nil
      end
    end

    @required_permissions = [] # Reset method chain

    action = [text, method, path, options]
    actions << action
    action
  end
end
