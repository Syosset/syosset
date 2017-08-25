class Course
  include Mongoid::Document
  include Mongoid::Slug
  include Concerns::Descriptable
  include Concerns::Subscribable
  include Concerns::Collaboratable
  include Concerns::Announceable
  include Concerns::Linkable

  paginates_per 12
  slug :name

  belongs_to :department

  validates_numericality_of :course_id
  validates_presence_of :course_id, :name, :short_description, :content

  field :course_id, type: Integer

end
