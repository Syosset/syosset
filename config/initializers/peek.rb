module Peek::Views
  class Admin < View
    # admin toggle view
    def initialize(options = {})
    end
  end
end

Peek.into Peek::Views::Git, nwo: "Syosset/Web", sha: ENV["GIT_REV"]
Peek.into Peek::Views::Admin
Peek.into Peek::Views::Host, host: ENV["HOSTNAME"]
Peek.into Peek::Views::Redis
Peek.into Peek::Views::Mongo