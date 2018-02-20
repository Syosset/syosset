class Department
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Search
  include Mongoid::History::Trackable
  include Descriptable
  include Rankable
  include Subscribable
  include Collaboratable
  include Announceable
  include Linkable
  include Attachable

  slug :name
  paginates_per 12
  search_in :name, courses: %i[name course_id]
  track_history on: [:all]

  has_many :courses

  validates :name, presence: true
  validates :short_description, presence: true
  validates :markdown, presence: true

end
