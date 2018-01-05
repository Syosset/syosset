class Closure
  include Mongoid::Document

  field :start_date, type: Date
  field :end_date,   type: Date

  field :type,    type: String # custom type for styling, e.g snow
  field :content, type: String
  validates :content, length: { in: 16..128 }

  def self.active_closure
    return Rails.cache.fetch("nav_closure", expires_in: 5.minutes) do
      start_date = Time.now.in_time_zone("EST").hour >= 18 ? Date.tomorrow : Date.today
      Closure.where(:start_date.lte => start_date, :end_date.gte => Date.today).first
    end
  end
end
