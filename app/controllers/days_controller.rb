class DaysController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:fetch]

  def show
    render jsonapi: Day.first, include: [:closure]
  end

  def edit
    authorize :day
  end

  def update
    authorize :day
    Day.first.update(params)

    respond_to do |format|
      format.json { render json: {:success => true, :color => Day.first.color} }
      format.html { redirect_back :fallback_location => root_path, :notice => 'Day color updated.' }
    end
  end

  def fetch
    authorize :day, :update
    ResolveDayColorJob.perform_later
    render json: {:success => true, :message => 'Job queued.'}
  end

end
