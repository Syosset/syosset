class Period
  include Mongoid::Document

  belongs_to :user
  belongs_to :course

  field :period, type: Integer
  field :room, type: String
end