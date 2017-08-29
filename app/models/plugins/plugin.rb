module Plugin
  class Plugin
    include Mongoid::Document
    belongs_to :pluggable, polymorphic: true

    field :enabled, type: Boolean, default: false
  end
end
