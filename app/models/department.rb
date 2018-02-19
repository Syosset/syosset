class Department
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Search
  include Mongoid::History::Trackable
  include Concerns::Descriptable
  include Concerns::Rankable
  include Concerns::Subscribable
  include Concerns::Collaboratable
  include Concerns::Announceable
  include Concerns::Linkable
  include Concerns::Attachable

  slug :name
  paginates_per 12
  search_in :name, courses: %i[name course_id]
  track_history on: [:all]

  has_many :courses

  validates_presence_of :name, :short_description, :markdown
end
