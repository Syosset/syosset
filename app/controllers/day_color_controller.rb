class DayColorController < ApplicationController
  def day_color
    render json: "{\"current_day_color\":\"#{$redis.get("current_day_color")}\"}"
  end
end
