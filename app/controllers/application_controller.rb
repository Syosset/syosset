class ApplicationController < ActionController::Base
  include ScramUtils
  protect_from_forgery with: :exception

  rescue_from ScramUtils::NotAuthorizedError do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.new_user_session_path, :alert => "You are not authorized to perform that action at this time. Please try signing in!" }
    end
  end
end
