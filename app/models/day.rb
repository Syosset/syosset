# Note: This is a non mongoid-backed model

class Day
  attr_reader :color

  def initialize(color)
    @color = color
  end

  def self.first
    if Closure.active_closure || ($redis.get('current_day_color') == nil)
      new("No Color")
    else
      new($redis.get('current_day_color'))
    end
  end

  def update(params)
    unless params[:color] == 'No Color'
      $redis.set('current_day_color', params[:color])
    else
      $redis.del('current_day_color')
    end
  end
end
