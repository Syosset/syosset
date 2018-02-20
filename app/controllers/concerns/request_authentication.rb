# Fetches authorization and user info from current session
module RequestAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :fetch_authorization
  end

  def authenticate!
    redirect_to login_path, notice: 'You need to be signed in to do this.' unless Current.authorization
  end

  private

  def fetch_authorization
    authorization = Authorization.includes(:user).find(session[:authorization_id]) if session[:authorization_id]
    return unless authorization

    Current.authorization = authorization
    Current.user = authorization.user
  end
end