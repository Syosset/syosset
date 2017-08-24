class Department
  include Mongoid::Document
  include Mongoid::Slug
  include Concerns::Descriptable
  include Concerns::Rankable
  include Concerns::Subscribable
  include Concerns::Collaboratable
  include Concerns::Announceable
  include Concerns::Linkable

  slug :name
  field :phone, type: String, default: "(516) 364-5675"
  has_many :courses
  paginates_per 12
  
end
