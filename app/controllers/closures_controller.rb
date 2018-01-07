class ClosuresController < ApplicationController

  before_action :get_closure, only: [:show, :edit, :update, :destroy]

  def index
    @closures = Closure.all.order([:start_date, :asc])

    respond_to do |format|
      format.html
      format.json { render jsonapi: @closures }
    end
  end

  def show
  end

  def new
    @closure = Closure.new
    authorize @closure
  end

  def create
    @closure = Closure.new(closure_params)
    authorize @closure

    if @closure.save
      notify_integrations "*#{current_user.name}* created a closure starting on *#{@closure.start_date}*\n#{closure_url(@closure)}"
      redirect_to @closure, notice: 'Closure created.'
    else
      render action: 'new'
    end
  end

  def edit
    authorize @closure
  end

  def update
    authorize @closure
    if @closure.update(closure_params)
      notify_integrations "*#{current_user.name}* updated a closure starting on *#{@closure.start_date}*\n#{closure_url(@closure)}"
      redirect_to @closure, notice: 'Closure updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    authorize @closure
    @closure.destroy
    redirect_to closures_path, notice: 'Closure deleted.'
  end

  private

  def get_closure
    @closure = Closure.find(params[:id])
  end

  def closure_params
    params.require(:closure).permit(:start_date, :end_date, :type, :content)
  end

end