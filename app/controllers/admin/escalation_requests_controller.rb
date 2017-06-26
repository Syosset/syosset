module Admin
  class EscalationRequestsController < BaseController
    before_action :get_escalatable, only: [:new, :create]
    before_action :get_escalation_request, only: [:update, :destroy, :edit]

    def index
      authorize EscalationRequest
      @escalation_requests = EscalationRequest.all
    end

    def create
      authorize @escalatable, :edit

      @escalation_request = EscalationRequest.new(escalation_request_params)
      @escalation_request.requester = current_user
      @escalation_request.escalatable = @escalatable

      @escalation_request.save

      if @escalation_request.errors.empty?
          flash[:notice] = 'Escalation request successfully created.'
          redirect_to @escalatable
      else
          flash.now[:alert] = @escalation_request.errors.full_messages.first
          render action: 'new'
      end
    end

    def new
      authorize @escalatable, :edit
      @escalation_request = EscalationRequest.new(escalatable: @escalatable)
    end

    def edit
      authorize @escalatable, :edit
    end

    def update
      authorize @escalatable, :edit
      @escalation_request.update!(escalation_request_params)
      redirect_to @escalatable, flash: {:success => "Escalation request updated successfully."}
    end

    def destroy
      authorize @escalatable, :edit
      @escalation_request.destroy
      redirect_to @escalatable, flash: {:alert => "Escalation request destroyed"}
    end

    private
    def get_escalatable
      params.each do |name, value|
        if name =~ /(.+)_id$/
          return @escalatable =  $1.classify.constantize.find(value)
        end
      end
      nil
      redirect_to root_path, flash: {:alert => "Escalation requests can only be made from an escalatable."}
    end

    def get_escalation_request
      @escalation_request = EscalationRequest.find(params[:id])
    end

    def escalation_request_params
      params.permit(:escalation_request).permit!
    end
  end
end
