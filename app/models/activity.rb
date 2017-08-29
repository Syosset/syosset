class Activity
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Search
  include Mongoid::Enum
  include Concerns::Descriptable
  include Concerns::Rankable
  include Concerns::Subscribable
  include Concerns::Collaboratable
  include Concerns::Announceable
  include Concerns::Linkable

  validates_uniqueness_of :name

  slug :name
  paginates_per 12
  search_in :name

  enum :type, [:club, :group, :sport]

end
