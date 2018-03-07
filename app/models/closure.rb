class Closure
  include Mongoid::Document
  include Publishable

  field :start_date, type: Date
  field :end_date,   type: Date

  field :type, type: String # custom type for styling, e.g snow
  validates :markdown, length: { in: 16..128 }

  def self.active_closure
    start_date = Time.now.in_time_zone('EST').hour >= 18 ? Date.tomorrow : Date.today
    Closure.where(:start_date.lte => start_date, :end_date.gte => Date.today).first
  end
end
