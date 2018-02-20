class IntegrationsController < ApplicationController
  before_action :verify_admin
  before_action :get_integration, only: %i[clear_failures edit update destroy]

  def index
    @integrations = Integration.all
  end

  def new
    if params[:provider].nil?
      @providers = Integration.providers.values
      render 'providers'
    else
      unless Integration.providers.key? params[:provider]
        redirect_to new_integration_path, alert: 'Invalid provider ID.'
      end

      @integration = Integration.new(provider_id: params[:provider])
    end
  end

  def create
    params = integration_params
    @integration = Integration.new(provider_id: params[:provider])
    @integration.options = params.require(:options).permit(@integration.provider.options.keys).to_hash

    if @integration.save
      flash[:notice] = 'Integration successfully created.'
      begin
        redirect_to edit_integration_path(@integration)
      rescue StandardError
        redirect_to integrations_path
      end
    else
      flash.now[:alert] = @integration.errors.full_messages.first
      render action: 'new'
    end
  end

  def clear_failures
    Redis.current.decrby('integration_failures', @integration.failures.count)
    @integration.failures.clear
    @integration.save
    redirect_to edit_integration_path(@integration), notice: 'Cleared all failures.'
  end

  def edit; end

  def destroy
    Redis.current.decrby('integration_failures', @integration.failures.count)
    @integration.destroy
    redirect_to integrations_path, notice: 'Integration succesfully removed.'
  end

  def update
    options = integration_params.require(:options).permit(@integration.provider.options.keys).to_hash

    if @integration.update(options: options)
      flash[:notice] = 'Successfully updated integration.'
      redirect_to edit_integration_path(@integration)
    else
      render action: 'edit'
    end
  end

  private

  def verify_admin
    authorize :integrations, :edit
  end

  def get_integration
    @integration = Integration.find(params[:id])
  end

  def integration_params
    params.require(:integration).permit(:provider, options: {})
  end
end
