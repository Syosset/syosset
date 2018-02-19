class DaysController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:fetch]
  before_action :get_day

  def show
    render jsonapi: @day, include: [:closure]
  end

  def edit
    authorize @day
  end

  def update
    authorize @day
    @day.update(params)

    respond_to do |format|
      format.json { render json: { success: true, color: @day.color } }
      format.html { redirect_back fallback_location: root_path, notice: "Day color set to #{@day.color}." }
    end
  end

  def fetch
    authorize @day, :update
    ResolveDayColorJob.perform_later
    render json: { success: true, message: 'Job queued.' }
  end

  private

  def get_day
    @day = Day.today
  end
end
