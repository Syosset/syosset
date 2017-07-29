class Course
  include Mongoid::Document
  include Concerns::Descriptable
  include Concerns::Subscribable
  include Concerns::Collaboratable
  include Concerns::Announceable
  include Concerns::Linkable

  belongs_to :department

end
