class String
  def indefinite_articularize
    %w[a e i o u].include?(downcase.first) ? "an #{self}" : "a #{self}"
  end
end
