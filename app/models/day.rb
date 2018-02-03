# Note: This is a non mongoid-backed model

class Day
  attr_reader :date
  attr_reader :color

  def initialize(date, color)
    @date = date
    @color = color
  end

  def self.today
    today = Date.today
    new(Date.today, $redis.get("day##{today.to_time.to_i}:color"))
  end

  def update(params)
    @color = params[:color]
    save
  end

  def save
    $redis.set("#{prefix}:color", @color)
  end

  def id
    @date.to_time.to_i
  end

  def prefix
    "day##{id}"
  end

  def is_set?
    !@color.nil?
  end

end
