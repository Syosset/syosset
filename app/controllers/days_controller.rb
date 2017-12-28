class DaysController < ApplicationController

  def show
    @color = $redis.get('current_day_color')
    render json: {:color => @color}
  end

  def edit
    authorize :day
    @color = $redis.get('current_day_color')
  end

  def update
    authorize :day

    unless params[:color] == 'No Color'
      $redis.set('current_day_color', params[:color])
    else
      $redis.del('current_day_color')
    end

    respond_to do |format|
      format.json { render json: {:success => true, :color => $redis.get('current_day_color')} }
      format.html { redirect_back :fallback_location => root_path, :notice => 'Day color updated.' }
    end
  end

  def fetch
    authorize :update, :day
    ResolveDayColorJob.perform_later
    render json: {:success => true, :message => 'Job queued.'}
  end

  # required by ryan lefkowitz's app
  # todo: migrate app to `GET /day` and remove this one
  def legacy_show
    render json: {:current_day_color => $redis.get('current_day_color')}
  end

end
