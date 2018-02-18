require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

module Clock
  include Clockwork

  every(1.day, 'Calculate day schedule color', at: '00:01', tz: 'UTC') do
    ResolveDayColorJob.perform_later
  end
end