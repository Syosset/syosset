class BulletinsController < ApplicationController
  before_action :get_bulletin, only: %i[show edit update destroy]

  def index
    @bulletins = Bulletin.order_by(date: :desc).limit(7)

    actions_builder = ActionsBuilder.new(current_holder)

    actions_builder.require(:edit)
                   .render('New Bulletin', :get, new_bulletin_path)

    @actions = actions_builder.actions
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder, bulletin: @bulletin)

    actions_builder.require(:edit) do
      render('Edit Bulletin', :get, edit_bulletin_path(bulletin))
      render('Destroy Bulletin', :delete, bulletin_path(bulletin), data: { confirm: 'Are you sure?' })
      render('View Audit Log', :get, history_trackers_path(bulletin_id: bulletin))
    end

    @actions = actions_builder.actions
  end

  def create
    @bulletin = Bulletin.new(bulletin_params)
    authorize @bulletin
    @bulletin.save

    if @bulletin.errors.empty?
      flash[:notice] = 'Bulletin successfully created.'
      redirect_to @bulletin
    else
      flash.now[:alert] = @bulletin.errors.full_messages.first
      render action: 'new'
    end
  end

  def new
    authorize @bulletin, :edit
    @bulletin = Bulletin.new
  end

  def edit
    authorize @bulletin, :edit
  end

  def update
    authorize @bulletin, :edit
    @bulletin.update!(bulletin_params)
    redirect_to @bulletin, flash: { success: 'Bulletin has been updated' }
  end

  def destroy
    authorize @bulletin, :edit
    @bulletin.destroy
    redirect_to bulletins_path, flash: { alert: 'Bulletin destroyed' }
  end

  private

  def get_bulletin
    @bulletin = Bulletin.find(params[:id])
  end

  def bulletin_params
    params.require(:bulletin).permit(:date, :markdown).merge(modifier: Current.user)
  end
end
