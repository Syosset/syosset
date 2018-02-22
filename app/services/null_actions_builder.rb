class NullActionsBuilder
  def require(node, context, &block)
    return self
  end

  def render(text, method, path, options = {})
    return ''
  end
end
