module Admin
  class IntegrationsController < BaseController
    before_action :verify_admin
    before_action :get_integration, only: [:clear_failures, :edit, :update, :destroy]

    def index
      @integrations = Integration.all
    end

    def new
      @integration = Integration.new
    end

    def create
      @integration = Integration.new(integration_params)

      if @integration.save
        if send_to_integration @integration, "Hello world! This integration has been added to *#{request.host}* by *#{current_user.name}*."
          flash[:notice] = 'Integration successfully created.'
        else
          flash[:alert] = 'The integration was created, but the ping message failed. Check the failure log for more info.'
        end
        redirect_to edit_admin_integration_path(@integration) rescue redirect_to admin_integrations_path
      else
        flash.now[:alert] = @integration.errors.full_messages.first
        render action: 'new'
      end
    end

    def clear_failures
      $redis.decrby('integration_failures', @integration.failures.count)
      @integration.failures.clear
      @integration.save
      redirect_to edit_admin_integration_path(@integration), notice: 'Cleared all failures.'
    end

    def edit
    end

    def destroy
      send_to_integration @integration, "#{current_user.name} has removed this integration. Goodbye!"
      $redis.decrby('integration_failures', @integration.failures.count)
      @integration.destroy
      redirect_to admin_integrations_path, notice: 'Integration succesfully removed.'
    end

    def update
      if @integration.update_attributes(integration_params)
        if send_to_integration @integration, "This integration was updated by *#{current_user.name}* on *#{request.host}*."
          flash[:notice] = "Successfully updated integration."
        else
          flash[:alert] = 'The integration was updated, but the ping message failed. Check the failure log for more info.'
        end
        redirect_to edit_admin_integration_path(@integration)
      else
        render :action => 'edit'
      end
    end

    private
    def send_to_integration(integration, message)
      begin
        integration.create_provider.notify(message)
        true
      rescue => error
        integration.failures << IntegrationFailure.new(error: error.message, message: message)
        integration.save
        $redis.incr('integration_failures')
        false
      end
    end

    def verify_admin
      authorize :admin_panel, :users
    end

    def get_integration
      @integration = Integration.find(params[:id])
    end

    def integration_params
      ip = params.require(:integration).permit(:provider_name, :properties)
      unless ip[:properties].empty?
        ip[:properties] = JSON.parse(ip[:properties])
      else
        ip[:properties] = nil
      end
      return ip
    end

  end
end