module User::Badged
  extend ActiveSupport::Concern

  included do
    belongs_to :badge, optional: true
  end
end
