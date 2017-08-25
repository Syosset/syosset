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

  field :course_id, type: Integer

end
