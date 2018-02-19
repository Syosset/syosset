module NotFoundRedirect
  extend ActiveSupport::Concern

  included do
    rescue_from ActionController::RoutingError, with: :not_found
    rescue_from Mongoid::Errors::DocumentNotFound, with: :not_found
  end

  private

  def not_found
    redirect_to root_path, alert: 'The page you requested does not exist.'
  end
end
