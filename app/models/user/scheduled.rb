module User::Scheduled
  extend ActiveSupport::Concern

  included do
    has_many :periods
  end
end