class ClosuresController < ApplicationController
  before_action :get_closure, only: %i[show edit update destroy]

  def index
    @closures = Closure.all.order(%i[start_date asc])

    actions_builder = ActionsBuilder.new(current_holder)

    actions_builder.require(:edit)
                   .render('New Closure', :get, new_closure_path)

    @actions = actions_builder.actions

    respond_to do |format|
      format.html
      format.json { render jsonapi: @closures }
    end
  end

  def show
    actions_builder = ActionsBuilder.new(current_holder, closure: @closure)

    actions_builder.require(:edit) do
      render('Edit Closure', :get, edit_closure_path(closure))
      render('Destroy Bulletin', :delete, closure_path(closure), data: { confirm: 'Are you sure?' })
    end

    @actions = actions_builder.actions
  end

  def new
    @closure = Closure.new
    authorize @closure
  end

  def create
    @closure = Closure.new(closure_params)
    authorize @closure

    if @closure.save
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
    params.require(:closure).permit(:start_date, :end_date, :type, :markdown)
  end
end
