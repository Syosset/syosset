class EscalationRequestsController < ApplicationController
  before_action :get_escalatable, only: [:new, :create, :edit, :update]
  before_action :get_escalation_request, only: [:update, :destroy, :edit, :approve, :deny]

  def approve
    authorize @escalation_request, :approve
    @escalation_request.approve!(current_user)
    flash[:notice] = 'Escalation request successfully approved.'
    redirect_back(fallback_location: root_path)
  end

  def deny
    authorize @escalation_request, :deny
    @escalation_request.deny!(current_user)
    flash[:notice] = 'Escalation request successfully denied.'
    redirect_back(fallback_location: root_path)
  end

  def index
    authorize EscalationRequest
    @escalation_requests = EscalationRequest.filter(params.slice(:status)).desc(:updated_at)
  end

  def create
    authorize @escalatable, :edit

    @escalation_request = EscalationRequest.new(escalation_request_params)
    @escalation_request.requester = current_user
    @escalation_request.escalatable = @escalatable

    @escalation_request.save

    if @escalation_request.errors.empty?
      type_name = @escalation_request.escalatable.class.to_s.downcase
      flash[:notice] = 'Escalation request successfully created.'
      safe_redirect_to @escalatable
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
    flash[:success] = 'Escalation request updated successfully.'
    safe_redirect_to @escalatable
  end

  def destroy
    authorize @escalatable, :edit
    @escalation_request.destroy
    flash[:alert] = 'Escalation request destroyed.'
    safe_redirect_to @escalatable
  end

  private
  def safe_redirect_to(model, controller: model.class.name.underscore.pluralize, action: :show)
    redirect_to url_for(id: model.id, controller: controller, action: action) rescue redirect_to root_path
  end

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
    @escalation_request = EscalationRequest.find(params[:id] || params[:escalation_request_id])
  end

  def escalation_request_params
    params.require(:escalation_request).permit(:note, :escalation_start_at, :escalation_end_at, "#{@escalatable.class.to_s.downcase}_id".to_sym)
  end
end
