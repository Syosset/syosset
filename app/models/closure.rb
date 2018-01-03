class Closure
  include Mongoid::Document

  field :start_date, type: Date
  field :end_date,   type: Date

  field :type,    type: String # custom type for styling, e.g snow
  field :content, type: String
  validates :content, length: { in: 16..128 }

end
