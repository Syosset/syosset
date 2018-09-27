class Course
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

  paginates_per 12
  slug :name
  search_in :name, :course_id
  track_history on: [:all]

  scram_define do
    condition :collaborators do |course|
      course.department.send('*collaborators') + User.in_group(course.collaborator_group)
                                                     .map(&:scram_compare_value).to_a
    end
  end

  belongs_to :department
  has_many :periods

  field :course_id, type: Integer
  validates :course_id, presence: true, numericality: true
end
