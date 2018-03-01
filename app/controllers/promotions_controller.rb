class PromotionsController < ApplicationController
  before_action :get_promotion, only: %i[show edit update destroy]

  def index
    @promotions = Promotion.all.by_priority
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder, promotion: @promotion)

    actions_builder.require(:edit) do
      render('Edit Promotion', :get, edit_promotion_path(promotion))
      render('View Audit Log', :get, history_trackers_path(promotion_id: promotion))
    end

    @actions = actions_builder.actions
  end

  def new
    @promotion = Promotion.new
    authorize @promotion
  end

  def create
    @promotion = Promotion.new(promotion_params)
    authorize @promotion

    if @promotion.save
      redirect_to promotion_path(@promotion), notice: 'Promotion created.'
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
      redirect_to promotion_path(@promotion), notice: 'Promotion updated.'
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
    params.require(:promotion).permit(:enabled, :text, :blurb, :picture).merge(modifier: Current.user)
  end
end
