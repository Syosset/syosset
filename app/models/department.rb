class Department
  include Mongoid::Document
  include Mongoid::Slug
  include Mongoid::Search
  include Mongoid::History::Trackable
  include Attachable
  include Publishable
  include Summarizable
  include Linkable
  include Announceable
  include Subscribable
  include Collaboratable
  include Rankable

  slug :name
  paginates_per 12
  search_in :name, courses: %i[name course_id]
  track_history on: [:all]

  # either 'instructional' or 'administrative'
  field :type, type: String, default: 'instructional'

  has_many :courses
end
