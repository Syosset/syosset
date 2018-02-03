# Note: This is a non mongoid-backed model

class Day
  attr_reader :color
  attr_reader :updated_at

  def initialize(color, updated_at)
    @color = color
    @updated_at = updated_at
  end

  def self.first
    new($redis.get('day#syosseths:color'), $redis.get('day#syosseths:updated_at'))
  end

  def update(params)
    unless params[:color] == 'No Color'
      $redis.set('day#syosseths:color', params[:color])
    else
      $redis.del('day#syosseths:color')
    end
    $redis.set('day#syosseths:updated_at', Time.now.to_i)
  end

  def id
    "syosseths"
  end

  def is_set?
    !@color.nil?
  end
end
