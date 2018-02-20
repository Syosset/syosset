class Activity
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Search
  include Mongoid::History::Trackable
  # include Mongoid::Enum
  include Concerns::Descriptable
  include Concerns::Rankable
  include Concerns::Subscribable
  include Concerns::Collaboratable
  include Concerns::Announceable
  include Concerns::Linkable

  validates :name, uniqueness: true

  slug :name
  paginates_per 12
  search_in :name
  track_history on: [:fields]

  # enum :type, [:club, :group, :sport] TODO: Fix mongoid-enum to support symbol storage
  validates :type, inclusion: { in: %w[club group sport],
                                message: '%{value} must be a club, group, or sport' }
  field :type, type: String
end
