class PromotionsController < ApplicationController

  before_action :get_promotion, only: [:edit, :update, :destroy]

  def index
    @promotions = Promotion.all.by_priority
  end

  def new
    @promotion = Promotion.new
    authorize @promotion
  end

  def create
    @promotion = Promotion.new(promotion_params)
    authorize @promotion

    if @promotion.save
      redirect_to promotions_path, notice: 'Promotion created.'
    else
      render action: 'new'
    end
  end

  def edit
    authorize @promotion
  end

  def update
    authorize @promotion
    if @promotion.update(promotion_params)
      redirect_to promotions_path, notice: 'Promotion updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize @promotion
    @promotion.destroy
    redirect_to promotions_path, notice: 'Promotion deleted.'
  end

  private

  def get_promotion
    @promotion = Promotion.find(params[:id])
  end

  def promotion_params
    params.require(:promotion).permit(:text, :picture)
  end
end