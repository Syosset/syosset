class BadgesController < ApplicationController

  before_action :get_badge, only: [:edit, :update, :destroy]

  def index
    @badges = Badge.all
  end

  def new
    @badge = Badge.new
    authorize @badge
  end

  def create
    @badge = Badge.new(badge_params)
    authorize @badge

    if @badge.save
      redirect_to badges_path, notice: 'Badge created.'
    else
      render action: 'new'
    end
  end

  def edit
    authorize @badge
  end

  def update
    authorize @badge
    if @badge.update(badge_params)
      redirect_to badges_path, notice: 'Badge updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize @badge
    @badge.destroy
    redirect_to badges_path, notice: 'Badge deleted.'
  end

  private

  def get_badge
    @badge = Badge.find(params[:id])
  end

  def badge_params
    params.require(:badge).permit(:name, :icon, :color)
  end
end
