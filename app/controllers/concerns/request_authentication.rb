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
    authorization = fetch_session_authorization if session[:authorization_id]
    authorization = fetch_token_authorization if params[:token]
    return unless authorization

    Current.authorization = authorization
    Current.user = authorization.user
  end

  def fetch_session_authorization
    authorization = Authorization.includes(:user).find(session[:authorization_id]) if session[:authorization_id]
  end

  def fetch_token_authorization
    authorization = Authorization.includes(:user).from_token(params[:token])
  end
end
