module Peek::Views
  class Admin < View
    # admin toggle view
    def initialize(options = {})
    end
  end
end

Peek.into Peek::Views::Git, nwo: "Syosset/Web"
Peek.into Peek::Views::Admin
Peek.into Peek::Views::Host
Peek.into Peek::Views::Redis
Peek.into Peek::Views::Mongo