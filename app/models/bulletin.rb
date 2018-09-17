class Bulletin
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::History::Trackable
  include Attachable
  include Publishable

  track_history on: [:all]

  field :date, type: Date, default: Date.today
  validates :date, uniqueness: true

  def pretty_date
    date.strftime('%A %e %B, %Y')
  end
end
